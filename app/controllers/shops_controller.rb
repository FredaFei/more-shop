class ShopsController < ApplicationController
  def create
    shop = Shop.create create_params
    p 'shop#create---'
    p shop
    render_resource shop
  end
  
  def create_params
    params.permit(:logo)
  end
end
