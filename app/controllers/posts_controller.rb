class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only:[:destroy]
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    #build = Post.new(user: user)
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿が完了しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "投稿に失敗しました。"
      render :new
    end
      
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
  end

  def destroy
    #@postをどこかで定義する必要がある
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    #fallback_location: root_path は、戻るべきページがない場合には root_path に戻る仕様
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  #StrongPrameter
  def post_params
    params.require(:post).permit(:title, :image)
  end
  
  #削除しようとしているPostが本当にログインユーザが所有しているものかを確認
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
    redirect_to root_url
    end
  end

end
