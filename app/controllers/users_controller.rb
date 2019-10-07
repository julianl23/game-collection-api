class UsersController < ApplicationController

  # GET /users/:id(.:format)
  # GET /user
  def show
    @user = if params.key?(:id)
              User.find(params[:id])
            else
              current_user
            end

    # Returns null if no user is set
    render json: @user, include: %i[
      game_collection
    ]
  end
end
