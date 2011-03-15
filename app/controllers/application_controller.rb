class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :populate_site_menu
  before_filter :populate_categories

  def populate_site_menu
    @site_menu = Page.find_all.select{|p| p.site_menu_position}.sort{|a,b| a.site_menu_position <=> b.site_menu_position}
  end

  def populate_categories
    @categories = Page.all_categories
  end
end
