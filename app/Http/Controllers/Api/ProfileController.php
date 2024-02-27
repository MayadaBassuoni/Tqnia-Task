<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\Api\UserResource;
use Illuminate\Http\Request;

class ProfileController extends BaseController
{
    /**
     * View Profile Data
     */
    public function index()
    {
        try {
            $user = auth('sanctum')->user();

            return $this->sendResponse(new UserResource($user), 'Profile Details : '.$user->name);

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }
}
