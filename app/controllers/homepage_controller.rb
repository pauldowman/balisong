class HomepageController < ApplicationController
  def index
    @recent_posts = Page.recent_posts(5)
  end
end
