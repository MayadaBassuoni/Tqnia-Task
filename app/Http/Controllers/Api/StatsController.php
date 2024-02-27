<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Post;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class StatsController extends Controller
{
    /**
     * Get stats
     */
    public function getStats()
    {
        try {
            if (Cache::has('stats')) {
                return Cache::get('stats');
            }

            $stats = $this->calculateStats();
            Cache::put('stats', $stats, now()->addMinutes(60));
            //we can also use Cache::forever('stats'); to save cache without limit time

            return $stats;

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Calculate Stats
     */
    private function calculateStats()
    {
        $total_users = User::count();
        $total_posts = Post::count();
        $users_with_no_posts = User::doesntHave('posts')->count();

        return [
            'total_users'         => $total_users,
            'total_posts'         => $total_posts,
            'users_with_no_posts' => $users_with_no_posts,
        ];
    }
}
