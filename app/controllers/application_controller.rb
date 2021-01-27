class ApplicationController < ActionController::API
  def render_resource(resource)
    return head 404 if resource.nil?
    render json: {resource: resource}, status: 200
  end
end
