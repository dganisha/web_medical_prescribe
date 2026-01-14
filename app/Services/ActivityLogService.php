<?php

namespace App\Services;

use App\Models\ActivityLog;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;

class ActivityLogService
{
    public function log(
        string $action,
        ?User $user = null,
        ?Model $entity = null,
        ?string $description = null,
        array $metadata = []
    ): ActivityLog {
        return ActivityLog::create([
            'user_id' => $user?->id,
            'action' => $action,
            'entity_type' => $entity ? $entity::class : null,
            'entity_id' => $entity?->id,
            'description' => $description,
            'metadata' => $metadata ?: null,
        ]);
    }
}
