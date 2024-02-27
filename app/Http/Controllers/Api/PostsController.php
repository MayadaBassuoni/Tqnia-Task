<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\PostStoreRequest;
use App\Http\Requests\Api\PostUpdateRequest;
use App\Http\Resources\Api\PostResource;
use App\Http\Resources\Api\TagResource;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PostsController extends BaseController
{
    protected $user_id;

    public function __construct()
    {
        $this->middleware('auth:sanctum');
        $this->user_id = auth('sanctum')->user()->id??0;
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $posts = Post::where('user_id', $this->user_id)
                         ->orderBy('pinned', 'desc')
                         ->orderBy('id', 'desc')
                         ->get();

            return $this->sendResponse(PostResource::collection($posts), 'All User Posts');

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(PostStoreRequest $request)
    {
        try {
            $data = $request->except('tags', 'cover_image');
            //Add User Id to Data
            $data['user_id'] = $this->user_id;

            //Add Image to Data
            $image = $request->cover_image;
            $data['cover_image'] = Storage::disk('public')->putFile('posts', $image);

            //Create New Post
            $post = Post::create($data);

            //Add Post Tags
            $tags = $post->tags()->attach($request->tags);
            return $this->sendResponse(new PostResource($post), 'New Post has been added successfully.');

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Post $post)
    {
        try {
            return $this->sendResponse(new PostResource($post), 'Details of single post ( '.$post->title.' )');
        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(PostUpdateRequest $request, Post $post)
    {
        try {
            if ($post->user_id == $this->user_id) {
                $data = $request->except('tags', 'cover_image');

                //Update Image to Data if exists
                if ($request->has('cover_image')) {
                    $image = $request->cover_image;
                    Storage::disk('public')->delete($post->cover_image);
                    $data['cover_image'] = Storage::disk('public')->putFile('posts', $image);
                }

                //Update Post Tags
                $tags = $post->tags()->sync($request->tags);

                //Update Post
                $post->update($data);

                return $this->sendResponse(new PostResource($post), 'Post has been updated successfully.');
            } elseif ($post->trashed()) {
                return $this->sendError('This post deleted, Restore it first.');
            } else {
                return $this->sendError('You can\'t update this post.');
            }

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try {
            $post = Post::find($id);

            if ($post && $post->user_id == $this->user_id) {
                $post->delete();
                return $this->sendResponse([], 'Post has been deleted successfully.');
            }
            return $this->sendError('No Such Post.');

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * View User Deleted Posts
     */
    public function deletedPosts()
    {
        try {
            $deletedPosts = Post::onlyTrashed()->where('user_id', $this->user_id)->get();
            return $this->sendResponse(PostResource::collection($deletedPosts), 'All User Deleted Posts');

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }

    /**
     * Restore Specific Post
     */
    public function restorePost($id)
    {
        try {
            $post = Post::withTrashed()->find($id);

            if ($post->trashed()) {
                $post->restore();
                return $this->sendResponse(new PostResource($post), 'Post has been restored successfully.');
            }
            return $this->sendError('This post didn\'t delete.');

        } catch (\Throwable $th) {
            return $this->sendError($th->getMessage());
        }
    }
}
