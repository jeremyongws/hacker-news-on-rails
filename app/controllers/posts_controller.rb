class PostsController < ApplicationController

	def index
		@user = User.find(userposts_params[:user_id])
	end

	def show
		@post = Post.find(show_params[:id])
		@comment_votes = []
		@post.comments.each do |comment|
			count = 0
			comment.comments_votes.each do |comments_vote|
				count += comments_vote.vote
			end
			# @post_votes = array of total votes for all posts
			@comment_votes << count
		end
	end

	def vote
		# byebug
		PostsVote.create(
			user_id: session[:id],
			post_id: vote_params[:post_id].to_i,
			vote: vote_params[:vote].to_i)
		@post = Post.find(vote_params[:post_id])
		votes_total = @post.posts_votes.sum(:vote)
		# @post.posts_votes.pluck(:vote).inject(:+)
		render json: {post_id: @post.id, votes: votes_total}
	end

	private

	def show_params
	  	params.permit(:id)
  	end

  	def userposts_params
  		params.permit(:user_id)
  	end

  	def vote_params
  		params.permit(:post_id, :vote)
  	end

end
