class ToppagesController < ApplicationController
  def index
    @posts = Post.all.order(id: :desc)
  end
end
