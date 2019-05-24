class RegistrationsController < Devise::RegistrationsController
  respond_to :json


  # The params expected here will always be included in a user object.
  # EX:
  # {
  #   "user": {
  #     "first_name": "Julian",
  #     "last_name": "Lord",
  #     "email": "julianl23@gmail.com",
  #     "username": "julianl23",
  #     "password": "password",
  #     "password_confirmation": "password"
  #   }
  # }
  def create
    build_resource sign_up_params
    render nothing: true, status: :bad_request unless resource.valid?

    resource.save
    yield resource if block_given?

    respond_with resource
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end