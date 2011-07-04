class HomepageController < ApplicationController
  def index
    @recent_posts = Page.find_all(:id => lambda{|id| id =~ /(\d{4}-\d{2}-\d{2})-.+/}, :order_by => :id, :order => :desc, :limit => 5)
  end
end
