class PostsController < ApplicationController
  #直打ち閲覧防止用コード
  before_action :require_user_logged_in
  before_action :correct_user, only:[:edit, :update, :destroy]
  #共通部分 @post = Post.find(params[:id]) をまとめる
  before_action :set_post, only:[:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end
  
  def show
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
  end

  def update
    if @post.update(post_params)
      flash[:success] = "編集が完了しました。"
      redirect_to @post
    else
      flash.now[:danger] = "編集に失敗しました。"
      render :edit
    end
    
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to root_path
  end
  
  private
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  #StrongPrameter
  def post_params
    params.require(:post).permit(:title, :image)
  end
  
  #編集・削除しようとしているPostが本当にログインユーザが所有しているものかを確認
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
    redirect_to root_url
    end
  end

end