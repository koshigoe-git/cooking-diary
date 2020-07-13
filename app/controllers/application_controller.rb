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
    @count_posts = user.posts.count
    @count_favorites = user.favorites.count
    #「いいね」を押してくれたユーザーの数を表示させたい
    #@count_fovorite_users = favorite.user.count
  end
end
