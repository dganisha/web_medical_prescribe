<?php

namespace App\Services;

class ReceiptPdfService
{
    private const PAGE_WIDTH = 227;
    private const PAGE_HEIGHT = 600;
    private const LEFT_MARGIN = 16;
    private const TOP_MARGIN = 24;
    private const MAX_CHARS = 42;

    public function buildReceiptPdf(array $lines): string
    {
        $contentLines = [];
        $y = self::PAGE_HEIGHT - self::TOP_MARGIN;

        foreach ($lines as $line) {
            foreach ($this->wrapLine($line) as $wrappedLine) {
                $escaped = $this->escapeText($wrappedLine);
                $contentLines[] = "BT /F1 10 Tf " . self::LEFT_MARGIN . " {$y} Td ({$escaped}) Tj ET";
                $y -= 14;
            }
        }

        $content = implode("\n", $contentLines);
        $objects = [
            "<< /Type /Catalog /Pages 2 0 R >>",
            "<< /Type /Pages /Kids [3 0 R] /Count 1 >>",
            "<< /Type /Page /Parent 2 0 R /MediaBox [0 0 " . self::PAGE_WIDTH . " " . self::PAGE_HEIGHT . "] /Contents 4 0 R "
                . "/Resources << /Font << /F1 5 0 R >> >> >>",
            "<< /Length " . strlen($content) . " >>\nstream\n{$content}\nendstream",
            "<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>",
        ];

        $pdf = "%PDF-1.4\n";
        $offsets = [];

        foreach ($objects as $index => $object) {
            $objectNumber = $index + 1;
            $offsets[$objectNumber] = strlen($pdf);
            $pdf .= "{$objectNumber} 0 obj\n{$object}\nendobj\n";
        }

        $xrefOffset = strlen($pdf);
        $pdf .= "xref\n0 " . (count($objects) + 1) . "\n";
        $pdf .= "0000000000 65535 f \n";

        foreach ($offsets as $offset) {
            $pdf .= sprintf("%010d 00000 n \n", $offset);
        }

        $pdf .= "trailer\n<< /Size " . (count($objects) + 1) . " /Root 1 0 R >>\n";
        $pdf .= "startxref\n{$xrefOffset}\n%%EOF";

        return $pdf;
    }

    private function escapeText(string $text): string
    {
        return str_replace(['\\', '(', ')'], ['\\\\', '\\(', '\\)'], $text);
    }

    private function wrapLine(string $line): array
    {
        if (mb_strlen($line) <= self::MAX_CHARS) {
            return [$line];
        }

        $chunks = [];
        $offset = 0;
        $length = mb_strlen($line);

        while ($offset < $length) {
            $chunks[] = mb_substr($line, $offset, self::MAX_CHARS);
            $offset += self::MAX_CHARS;
        }

        return $chunks;
    }
}
