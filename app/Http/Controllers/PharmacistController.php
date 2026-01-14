<?php

namespace App\Http\Controllers;

use App\Models\Prescription;
use App\Services\ActivityLogService;
use App\Services\PharmacistService;
use App\Services\ReceiptPdfService;

class PharmacistController extends Controller
{
    private PharmacistService $pharmacistService;
    private ReceiptPdfService $receiptPdfService;
    private ActivityLogService $activityLogService;

    public function __construct(
        PharmacistService $pharmacistService,
        ReceiptPdfService $receiptPdfService,
        ActivityLogService $activityLogService
    ) {
        $this->pharmacistService = $pharmacistService;
        $this->receiptPdfService = $receiptPdfService;
        $this->activityLogService = $activityLogService;
    }

    public function index()
    {
        $this->authorizePharmacist();

        $prescriptions = $this->pharmacistService->listPendingPrescriptions();
        $servedPrescriptions = $this->pharmacistService->listServedPrescriptions();
        $totals = [];
        $servedTotals = [];

        foreach ($prescriptions as $prescription) {
            $totals[$prescription->id] = $this->pharmacistService->calculateTotals($prescription);
        }

        foreach ($servedPrescriptions as $prescription) {
            $servedTotals[$prescription->id] = $this->pharmacistService->calculateTotals($prescription);
        }

        return view('pharmacy.index', compact('prescriptions', 'totals', 'servedPrescriptions', 'servedTotals'));
    }

    public function show(Prescription $prescription)
    {
        $this->authorizePharmacist();

        $prescription = $this->pharmacistService->getPrescriptionWithItems($prescription->id);

        if (!$prescription) {
            abort(404);
        }

        $totals = $this->pharmacistService->calculateTotals($prescription);

        return view('pharmacy.show', compact('prescription', 'totals'));
    }

    public function serve(Prescription $prescription)
    {
        $this->authorizePharmacist();

        $this->pharmacistService->servePrescription($prescription, auth()->user());

        $this->activityLogService->log(
            'pharmacy.prescription_served',
            auth()->user(),
            $prescription,
            'Prescription served by pharmacist.'
        );

        return redirect()
            ->route('pharmacy.show', $prescription)
            ->with('success', 'Prescription served successfully.');
    }

    public function receipt(Prescription $prescription)
    {
        $this->authorizePharmacist();

        $prescription = $this->pharmacistService->getPrescriptionWithItems($prescription->id);

        if (!$prescription) {
            abort(403);
        }

        $totals = $this->pharmacistService->calculateTotals($prescription);
        $lines = $this->buildReceiptLines($prescription, $totals);
        $pdf = $this->receiptPdfService->buildReceiptPdf($lines);

        $this->activityLogService->log(
            'pharmacy.receipt_downloaded',
            auth()->user(),
            $prescription,
            'Receipt downloaded.'
        );

        return response($pdf, 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'attachment; filename="receipt-' . $prescription->id . '.pdf"',
        ]);
    }

    private function authorizePharmacist(): void
    {
        if (!$this->pharmacistService->canPharmacistManage(auth()->user())) {
            abort(403);
        }
    }

    private function buildReceiptLines(Prescription $prescription, array $totals): array
    {
        $checkup = $prescription->checkupResult;
        $lines = [
            $this->formatLine('RS Delta Surya', '', true),
            $this->formatLine('Resi Pembayaran Resep', '', true),
            $this->separatorLine(),
            $this->formatLine('Nomor', (string) $prescription->id),
            $this->formatLine('Tanggal', now()->format('Y-m-d H:i')),
            $this->formatLine('Pasien', $checkup->patient->name ?? '-'),
            $this->formatLine('Dokter', $checkup->doctor->name ?? '-'),
            $this->separatorLine(),
            $this->formatLine('Item', 'Total'),
        ];

        foreach ($totals['items'] as $itemData) {
            $item = $itemData['item'];
            $name = $item->medicine->name . ' x' . $item->quantity;
            $price = 'Rp' . number_format($itemData['line_total'], 0, ',', '.');
            $lines[] = $this->formatLine($name, $price);
        }

        $lines[] = $this->separatorLine();
        $lines[] = $this->formatLine('Total', 'Rp' . number_format($totals['total'], 0, ',', '.'));
        $lines[] = $this->separatorLine();
        $lines[] = $this->formatLine('Terima kasih', '', true);

        return $lines;
    }

    private function formatLine(string $left, string $right, bool $center = false): string
    {
        $width = 42;
        if ($center) {
            $text = trim($left . ' ' . $right);
            $padding = max(0, (int) floor(($width - strlen($text)) / 2));
            return str_repeat(' ', $padding) . $text;
        }

        $left = substr($left, 0, $width);
        $right = substr($right, 0, $width);
        $space = max(1, $width - strlen($left) - strlen($right));

        return $left . str_repeat(' ', $space) . $right;
    }

    private function separatorLine(): string
    {
        return str_repeat('-', 42);
    }
}
