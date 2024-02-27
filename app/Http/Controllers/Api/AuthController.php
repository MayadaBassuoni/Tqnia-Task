<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\RegisterRequest;
use App\Http\Resources\Api\UserResource;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class AuthController extends BaseController
{
    /**
     * Register as new user
     */
    public function register(RegisterRequest $request)
    {
        try {
            $password = bcrypt($request->password);
            $user = User::create([
                'name'     => $request->name,
                'phone'    => $request->phone,
                'password' => $password
            ]);

            $verification_code = rand(100000, 999999);
            User::where('id', $user->id)->update([
                'verification_code' => $verification_code
            ]);

            Log::info('This is verification code of user #'.$user->id.' :'.$verification_code);
            $user['token'] = $user->createToken('authToken')->plainTextToken;
            //You need 'access_token' returned with data and i do it in previous line, But i think we shouldn't send 'access_token' before verifying account

            return $this->sendResponse(new UserResource($user), 'You have been registerd successfully.');

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Login user
     */
    public function login(Request $request)
    {
        try {
            if (Auth::attempt($request->only('phone', 'password'))) {
                $user = Auth::user();
                if ($user->user_verified_at == null) {
                    return $this->sendError('This user didn\'t verify yet.');
                }

                $user['token'] = Auth::user()->createToken('authToken')->plainTextToken;

                return $this->sendResponse(new UserResource($user), 'Welcome Back, '.$user->name);
            }

            return $this->sendError('Sorry, Phone Or Password may be wrong.');

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Verify User Account
     */
    public function verify(Request $request)
    {
        try {
            $user = User::where('phone', $request->phone)->first();

            if ($user) {
                if ($user->user_verified_at != null) {
                    return $this->sendError('Your Account is already verified.');
                } elseif ($user->user_verified_at == null && ($user->verification_code == $request->verification_code)) {
                    $user->update([
                        'verification_code' => null,
                        'user_verified_at'  => Carbon::now()
                    ]);

                    $user['token'] = $user->createToken('authToken')->plainTextToken;

                    return $this->sendResponse(new UserResource($user), 'This Account is verified now.');
                } else {
                    return $this->sendError('Please check verification code which you entered.');
                }
            }

        } catch (\Throwable $th) {
            return $this->sendError('This user isn\'t found.');
        }
    }

    public function logout()
    {
        try {
            $user = auth('sanctum')->user();
            if ($user) {
                $user->currentAccessToken()->delete();
                return $this->sendResponse([], 'Goodbye, See you soon.');
            }
            return $this->sendError('No Logged User.');

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }
}
