class UsersController < ApplicationController
  def login
    user = User.find_by(email: login_params[:email])

    if user.compare_password?(password: login_params[:password])
      response(body: { message: 'Success', jwt: user.generate_jwt, user: user.user_response_data })
    else
      response(body: { message: 'error', error: 'Invalid credentials' }, status: :unauthorized)
    end
  end

  def register
    user = User.new(register_params)
    if user.save
      response(body: { status: 'Success', jwt: user.generate_jwt, user: user.user_response_data })
    else
      response(body: { status: 'Error', message: user.errors }, status: :unprocessable_entity)
    end
  end

  def authorize
    user_id = Jwt.new.user_id(request.headers['Authorization'])
    user = User.find_by(id: user_id)
    if user.present?
      response(body: { status: 'Success' })
    else
      response(body: { status: 'Error', message: 'Invalid token' }, status: :unauthorized)
    end
  end

  def register_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end

  def login_params
    params..require(:user).permit(:email, :password)
  end
end
