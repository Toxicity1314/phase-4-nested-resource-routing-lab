class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = Item.where(user_id: user)
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  def create
   item = Item.create!(item_params)
   render json: item, include: :user, status: :created
  end

  private
  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
  def render_record_not_found(invalid)
    render json: {errors: invalid}, status: 404
  end

end
