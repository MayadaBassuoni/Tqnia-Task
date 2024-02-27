<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    /**
     * Get Posts
     */
    public function posts()
    {
        return $this->belongsToMany(Post::class, 'post_tags', 'post_id', 'tag_id')->withTimestamps();
    }
}
