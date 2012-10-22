class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      #~ @feed_items = current_user.feed.paginate(page: params[:page])  # I like this better, but it's not what's done in the tutorial
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

		def correct_user
			@micropost = current_user.microposts.find(params[:id])
		rescue
			redirect_to root_url
		end
		
end
