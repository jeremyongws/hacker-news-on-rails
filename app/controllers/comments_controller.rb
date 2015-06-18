class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
		# byebug
		if !session[:id].nil?
			# Can comment
			params.permit!
			@new_comment = Comment.create(post_params)
			byebug
			redirect_to "/posts/#{@new_comment.post_id}"
		else
			byebug
			redirect_to("/login")
		end
	end

	def index
		@user = User.find(params[:user_id])
	end

	private

	def post_params
	  	params.permit!
	    params.require(:post).permit(:post_id ,:comment_desc, :user_id)
  	end

end
