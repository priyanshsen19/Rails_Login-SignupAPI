class UsersController < ApplicationController
    def create
        @user=User.create(user_params)
        if @user.save && @user.valid?
            token = encode_token({user_id: @user.id})
            puts(token)
            puts(@user)
            @user.update!(
                :confirmed_at => token  #stores the token at confirmed_at
            )
            render json: { user: @user, token: token,status: 'User created successfully'}, status: :ok
            
            
        else
            render json: { error: @user.errors.full_messages }, status: :bad_request
        end
    end
    def login
        @user = User.find_by(username: user_params[:username]
        if @user && @user.authenticate(user_params[:password])
            token = encode_token( {user_id: @user_id})
            render json: {user: @user, token:token, status: 'Logged in successfully'},status: :ok
        else
            render json: { error: 'Invalid username / password' }, status: :bad_request
        end
    end
      
    private
      
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :phone_number)
    end
end
