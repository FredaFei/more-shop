class UsersController < ApplicationController
  def create
    render_resource User.create create_params
  end
  
  def create_params
    params.permit(:phone, :password, :password_confirmation)
  end
end
