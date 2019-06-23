class UsersController < ApplicationController
  # GET /users/:id(.:format)
  def show
    @user = User.find(params[:id])
    render json: @user
  end
end
