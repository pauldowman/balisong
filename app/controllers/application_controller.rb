class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :populate_site_menu

  def populate_site_menu
    @site_menu = Page.find_all(:site_menu_position => lambda{|x| !x.nil?}, :order_by => :site_menu_position, :order => :asc)
  end
end
