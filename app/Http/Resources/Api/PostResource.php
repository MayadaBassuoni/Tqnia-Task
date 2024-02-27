<?php

namespace App\Http\Resources\Api;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PostResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $data = [
            'id'          => $this->id,
            'user'        => UserResource::make($this->whenLoaded('user')),
            'title'       => $this->title,
            'body'        => $this->body,
            'cover_image' => $this->cover_image,
            'pinned'      => $this->pinned,
            'tags'        => $this->tags->makeHidden(['created_at', 'updated_at', 'pivot'])
        ];

        if ($this->trashed()) {
            $data['deleted_at'] = $this->deleted_at;
        }

        return $data;
    }
}
