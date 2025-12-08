class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [ :create ]
  before_action :require_admin, only: [ :index ]

  # GET /users  (admin only)
  def index
    users = User.all.order(:id)
    render json: users.as_json(only: [ :id, :email, :role, :created_at ])
  end

  # POST /signup
  def create
    user = User.new(user_params)

    if user.save
      render json: {
        id: user.id,
        email: user.email,
        role: user.role
      }, status: :created

    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation, :role)
  end
end
