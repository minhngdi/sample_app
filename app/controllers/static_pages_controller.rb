class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost  = current_user.microposts.build
    @feed_items = Micropost.feed(current_user).by_desc
                           .paginate page: params[:page],
                           per_page: Settings.per_page_count
  end

  def help; end

  def about; end

  def contact; end
end
