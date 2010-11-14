class HomepageController < ApplicationController
  def index
    # TODO only show posts with date
    @recent_posts = Page.find_all.sort {|a,b| (b.date || Date.new) <=> (a.date || Date.new) }
    
    @categories = Page.all_categories
  end
end
