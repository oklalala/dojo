class Api::V1::PostsController < ApiController
  def index
    @posts = Post.all
    # @posts = Post.all
    # render json: {
    #   data: @posts.map do |post|
    #     {
    #       title: post.title,
    #       photo: post.photo,
    #       content: post.content
    #     }
    #   end
    # }
  end

  def show
    @photo = Photo.find_by(id: params[:id])
    if !@photo
      render json: {
        message: "Can't find the photo!",
        status: 400
      }
    else
      render 'api/v1/posts/show'
      # render json: {
      #   title: @post.title,
      #   photo: @post.photo,
      #   content: @post.content
      # }
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: {
        message: 'post created successfully!',
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      render json: {
        message: 'post updated successfully!',
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    render json: {
      message: 'post destroy successfully!'
    }
  end

  private

  def post_params
    params.permit(:title, :photo, :content)
  end
end
