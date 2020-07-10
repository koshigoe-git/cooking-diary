class ApplicationController < ActionController::Base
  
  #helper内のメソッドは基本viewの補助で使用するので、controllerではそのまま使えない
  #そのため、SessionHelperで定義したlogged_in?メソッドを使うには、include helper名を記述する
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_path
    end
  end
  
  def counts(user)
    @counts_post = user.posts.count
  end
end
