class ProductsController < ApplicationController
  def index
    if params[:search].present?
      @products = Product.joins(:category)
                         .where("products.name LIKE ? OR categories.name LIKE ?",
                                "%#{params[:search]}%",
                                "%#{params[:search]}%")
                         .includes(:category)
    else
      @products = Product.all.includes(:category)
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
