class UsersController < ApplicationController
  def signup
    if User.find_by(email: user_params[:email])
      render json: { status: 'error', message: 'User already exists' }, status: :conflict
      return
    end
    user = User.new(user_params)
    if user.save
      render json: { status: 'success', message: 'User successfully signed up', payload: { user_id: user.id } }
    else
      render json: { status: 'error', message: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { status: 'success', message: 'Login successful', payload: { user_id: user.id } }
    else
      render json: { status: 'error', message: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
