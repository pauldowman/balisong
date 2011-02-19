class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :populate_site_menu

  def populate_site_menu
    @site_menu = Page.find_all.select{|p| p.site_menu_position}.sort{|a,b| a.site_menu_position <=> b.site_menu_position}
  end
end
