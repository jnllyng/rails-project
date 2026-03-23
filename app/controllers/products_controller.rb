class ProductsController < ApplicationController
 def index
  if params[:search].present?
    @products = Product.joins(:category)
                       .where("products.name LIKE ? OR categories.name LIKE ?",
                              "%#{params[:search]}%",
                              "%#{params[:search]}%")
                       .includes(:category)
                       .page(params[:page]).per(12)
  else
    @products = Product.all.includes(:category).page(params[:page]).per(12)
  end
end

  def show
    @product = Product.find(params[:id])
  end
end
