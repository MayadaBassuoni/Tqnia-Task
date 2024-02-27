<?php

namespace App\Http\Resources\Api;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $data = [
            'id'           => $this->id,
            'name'         => $this->name,
            'phone'        => $this->phone,
            'verified'     => ($this->user_verified_at != null)? true : false
        ];

        if (isset($this->token)) {
            $data['access_token'] = $this->token;
        }

        return $data;
    }
}
