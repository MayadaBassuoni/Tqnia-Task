<?php

namespace App\Jobs;

use GuzzleHttp\Client;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class MakeRandomUser implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     */
    public function __construct()
    {
        //
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        $client = new Client();

        try {
            $response = $client->request('GET', 'https://randomuser.me/api/');
            $data = json_decode($response->getBody(), true);
            $results_only = $data['results'];
            Log::info('Random User API response:', $results_only);

        } catch (\Exception $e) {
            Log::error('Error occurred while making API request: ' . $e->getMessage());
        }
    }
}
