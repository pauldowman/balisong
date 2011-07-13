class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :populate_site_menu
  before_filter :populate_all_categories

  rescue_from GitModel::RecordNotFound, :with => :render_404
 
  private

  def render_404
    # Log a warning if there was a 404 from a link on our own site
    if request.referer =~ /#{request.env["SERVER_NAME"]}/
      Rails.logger.warn "Page not found: #{request.path}, referer was #{request.referer}"
    end
    render :template => "errors/404", :status => 404
  end

  def populate_site_menu
    @site_menu = Page.find_all(:site_menu_position => lambda{|x| !x.nil?}, :order_by => :site_menu_position, :order => :asc)
  end

  def populate_all_categories
    @all_categories = Page.all_categories
  end
end
