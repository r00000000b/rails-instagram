class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      # render success in Jbuilder
    else
      render json: { message: "400 Bad Request" }, status: :bad_request
    end
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render json: { message: "Cannot find post" }, status: :not_found
    else
      @post.update(post_params)
    end
  end

  def show
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render json: { message: "Cannot find post" }, status: :not_found
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render json: { message: "Cannot find post" }, status: :not_found
    else
      if @post.destroy
        render json: { message: "Successfully deleted" }, status: :no_content
      else
        render json: { message: "Unsuccessfully deleted" }, status: :bad_request
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category)
  end
end