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

	def vote
		# byebug
		CommentsVote.create(
			user_id: session[:id],
			comment_id: vote_params[:comment_id].to_i,
			vote: vote_params[:vote].to_i)
		@comment = Comment.find(vote_params[:comment_id])
		votes_total = @comment.comments_votes.sum(:vote)
		# @post.posts_votes.pluck(:vote).inject(:+)
		render json: {comment_id: @comment.id, votes: votes_total}
	end

	def index
		@user = User.find(params[:user_id])
	end

	private

	def post_params
  	params.permit!
    params.require(:post).permit(:post_id ,:comment_desc, :user_id)
  end

  def vote_params
		params.permit(:comment_id, :vote)
  end

end
