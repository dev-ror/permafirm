class OrderLineItemsController < ApplicationController
  before_action :set_order_line_item, only: [:show, :edit, :update, :destroy]

  # GET /order_line_items
  # GET /order_line_items.json
  def index
    @order_line_items = OrderLineItem.all
  end

  # GET /order_line_items/1
  # GET /order_line_items/1.json
  def show
  end

  # GET /order_line_items/new
  def new
    @order_line_item = OrderLineItem.new
  end

  # GET /order_line_items/1/edit
  def edit
  end

  # POST /order_line_items
  # POST /order_line_items.json
  def create
    @order_line_item = OrderLineItem.new(order_line_item_params)

    respond_to do |format|
      if @order_line_item.save
        format.html { redirect_to @order_line_item, notice: 'Order line item was successfully created.' }
        format.json { render :show, status: :created, location: @order_line_item }
      else
        format.html { render :new }
        format.json { render json: @order_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_line_items/1
  # PATCH/PUT /order_line_items/1.json
  def update
    respond_to do |format|
      if @order_line_item.update(order_line_item_params)
        format.html { redirect_to @order_line_item, notice: 'Order line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_line_item }
      else
        format.html { render :edit }
        format.json { render json: @order_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_line_items/1
  # DELETE /order_line_items/1.json
  def destroy
    @order_line_item.destroy
    respond_to do |format|
      format.html { redirect_to order_line_items_url, notice: 'Order line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_line_item
      @order_line_item = OrderLineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_line_item_params
      params.fetch(:order_line_item, {})
    end
end
