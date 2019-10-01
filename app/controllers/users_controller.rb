class UsersController < ApplicationController
before_action :authenticate_user!,{only:[:index,:show,:edit]}

	def index
		@book = Book.new
		@users = User.all
		@user = current_user
	end
	def show
		@user = User.find(params[:id])
		@book2 = Book.new
		@users = User.all
	end
	def edit
		@user_image = User.new
		@user = User.find(params[:id])
		# !=で異なるidの場合になる
		if @user.id != current_user.id
			redirect_to user_path(current_user)
		end
	end
	def update
		user = User.find(params[:id])
		if user.update(user_params)
		  flash[:notice] = "successfully"
		  redirect_to user_path(user)
		else
			 flash[:notice] = "error"
			 @user_image = User.new
			 @user = current_user
			 render :edit
		end
	end

private
    def user_params
    	params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
