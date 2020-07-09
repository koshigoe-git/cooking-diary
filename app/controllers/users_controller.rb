class UsersController < ApplicationController
  def index
    #page(params[:page]).per(取得数):ページネーションを適用
    @users = User.order(id: :desc).page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    #引数はフォーム内で記述
    @user = User.new
  end

  def create
    #引数はStrongPrameterで許可する
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザ登録が完了しました。"
      #createアクション実行後に更にusers#showアクションが実行され、show.html.erbを呼び出す
      #redirect_toの@userは省略形,本来は"/users/show(@user =表示したいUserクラスのインスタンス)" or user_path(@user)となっている
      redirect_to @user
    else
      flash.now[:danger] = "ユーザ登録に失敗しました。"
      render :new
    end
  end
  
  private
  
  #StrongPrameter
  def user_params
    params.require(:user).permit(:name, :email, :introduce, :password, :password_confirmation)
  end

end

