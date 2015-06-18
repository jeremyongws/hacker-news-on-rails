class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token  

  def login
  	@user = User.authenticate(params[:user][:username], params[:user][:password])
	if @user == nil
		render :show
	else
		# If the user is successfully authenticated
		session[:id] = @user.id
		redirect_to("/")
	end
  end

  def show
  	@posts = Post.all
	@post_votes = []
	@posts.each do |post|
		count = 0
		post.posts_votes.each do |posts_vote|
			count += posts_vote.vote
		end
		# @post_votes = array of total votes for all posts
		@post_votes << count
	end
  end

end
