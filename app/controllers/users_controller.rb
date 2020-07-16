class UsersController < ApplicationController
  #直打ち閲覧防止用コード
  before_action :require_user_logged_in, only:[:index, :show]
  before_action :correct_user, only:[:edit, :update]
  
  def index
    #page(params[:page]).per(取得数):ページネーションを適用
    @users = User.order(id: :desc).page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(8)
    counts(@user)
  end

  def new
    #引数はフォーム内で記述
    @user = User.new
  end

  def create
    #引数はStrongPrameterで許可する
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザ登録が完了しました。"
      #createアクション実行後に更にusers#showアクションが実行され、show.html.erbを呼び出す
      #redirect_toの@userは省略形,本来は"/users/show(@user =表示したいUserクラスのインスタンス)" or user_path(@user)となっている
      redirect_to @user
    else
      flash.now[:danger] = "ユーザ登録に失敗しました。"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end  
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "編集が完了しました。"
      redirect_to @user
    else
      flash.now[:danger] = "編集に失敗しました。"
      render :edit
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @favorite_posts = @user.favorite_posts.page(params[:page]).per(8)
    counts(@user)
  end
  
  private
  
  #StrongPrameter
  
  #編集(削除)しようとしているUserとログインユーザが同一かを確認
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_url
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :introduce, :password, :password_confirmation)
  end

end

