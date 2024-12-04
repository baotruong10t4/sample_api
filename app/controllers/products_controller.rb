class ProductsController < ApplicationController
  before_action :find_product, only: [ :show, :update, :destroy ]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product
      @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @product
      @product.destroy
      render json: { message: "Product successfully deleted." }, status: 200
    else
      render json: { error: "Product not found." }, status: 404
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :user_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
