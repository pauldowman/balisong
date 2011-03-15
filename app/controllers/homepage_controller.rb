class HomepageController < ApplicationController
  def index
    # PERFORMANCE: this won't work with lots of pages, gitmodel needs the
    # ability to query
    @recent_posts = Page.find_all.reject{|p| p.date.nil? }.sort {|a,b| (b.date || Date.new) <=> (a.date || Date.new) }
  end
end
