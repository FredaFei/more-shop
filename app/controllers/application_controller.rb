class ApplicationController < ActionController::API
  def current_user
    @current_user ||= User.find_by_id session[:current_user_id]
  end
  
  def render_resource(resource)
    return head 404 if resource.nil?
    render json: { resource: resource }, status: 200
  end
end
