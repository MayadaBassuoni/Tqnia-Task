<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\TagStoreRequest;
use App\Http\Requests\Api\TagUpdateRequest;
use App\Http\Resources\Api\TagResource;
use App\Models\Tag;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Validator;

class TagsController extends BaseController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $tags = Tag::all();
        	return $this->sendResponse(TagResource::collection($tags), 'All Tags');

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $names = $request->input('name');

            $tags = [];
            $tag_exists = [];
            foreach ($names as $single) {
                $validator = Validator::make([
                    'name' => $single
                ],[
                    'name' => 'required|string|unique:tags,name'
                ]);

                try {
                    $validator->stopOnFirstFailure()->validate();
                    $tag = Tag::create(['name' => $single]);
                    $tags[] = $tag;
                } catch (ValidationException $exception) {
                    $tag_exists[] = $single;
                }
            }

            if ($tag_exists) {
                return $this->sendError('Some tags already exist but other tags have been added successfully.', ['existing_tags' => $tag_exists]);
            } else {
                return $this->sendResponse(TagResource::collection($tags), 'New Tags have been added successfully.');
            }

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(TagUpdateRequest $request, $id)
    {
        try {
            $request->merge([
                'id' => $id
            ]);
            $validatedData = $request->validated();
            $tag = Tag::findOrFail($id);
            $tag->update($validatedData);

            return $this->sendResponse(new TagResource($tag), 'Tag has been updated successfully.');

        } catch (ValidationException $exception) {
            return $this->sendError($exception->validator->errors()->first());

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try{
            $tag = Tag::find($id);
            if($tag) {
                $tag->delete();

                return $this->sendResponse([], 'Tag has been deleted successfully.');
            }
            return $this->sendError('No Such Tag.');

        } catch  (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }
}
