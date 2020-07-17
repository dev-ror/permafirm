class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token ,only: [:create_product_on_shopify]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.order(id: 'ASC')
  end

  # GET /products/1
  # GET /products/1.json
  def show
    id = params[:id]
    @product = Product.find(id)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import_product
    shop = Shop.last
    shopify_session = ShopifyAPI::Session.new(domain: shop.shopify_domain ,api_version: ENV['API_VERSION'],token: shop.shopify_token)
    ShopifyAPI::Base.activate_session(shopify_session)
    new_product = ShopifyAPI::Product.new
    
    new_product.title = 'Test Product'
    new_product.product_type = 'test type'
    new_product.handle = 'Test handle'
    new_product.vendor = 'test vendor'

    new_product.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      # @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.fetch(:product, {})
    end
end
