class FavoritesController < ApplicationController
  def index
  end

  def new
    # 下記は、「NameError in FavoritesController#new uninitialized constant FavoritesController::Favorite Did you mean? FavoritesHelper」となってしまう。
    # @favorite = Favorite.new
  end

  def create
    favorite = Favorite.new(favorite_params)
    favorite.save!
    redirect_to favorites_url, notice: "お気に入りに「#{blog.name}」を登録しました。"
  end

  private

  def favorite_params
    params.require(:favorite).permit(:name, :description)
  end
end
