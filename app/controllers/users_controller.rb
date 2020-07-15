class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:index, :show]
  
  def index
    #page(params[:page]).per(取得数):ページネーションを適用
    @users = User.order(id: :desc).page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(4)
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
  private
  
  #StrongPrameter
  def user_indroduce_params
    params.require(:user).permit(:introduce)
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :introduce, :password, :password_confirmation)
  end

end

