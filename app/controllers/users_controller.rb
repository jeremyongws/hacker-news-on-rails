class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  
  def new
  end

  def create
  	@user = User.create(new_params)
  	@posts = Post.all
	if @user == nil
	  render :"comments/index"
	else
	  session[:id] = @user.id
	  render :new
	end
  end

  def show
  	@user = User.find(show_params[:id])
  end

  private
    # Using a private method to encapsulate the permissible parameters is
    # just a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.
  def new_params
  	params.permit!
    params.require(:new_user).permit(:username, :password, :dob, :email, :name)
  end

  def show_params
    params.permit(:id)
  end

end
