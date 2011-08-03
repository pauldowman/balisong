class PagesController < ApplicationController

  def show
    # convert '/' characters in id to '-'
    id = Page.de_urlify(params[:id])

    @page = Page.find(id)
    if params[:part]
      render_404 and return unless @page.blobs[params[:part]]
      # Request is for a part, it will be sent unformatted
      if params[:download]
        disposition = 'attachment'
        mime_type = 'application/octet-stream'
      else
        disposition = 'inline'
        t = MIME::Types.type_for(params[:part])
        mime_type = t.any? ? t.first.content_type : 'application/octet-stream'
      end
      send_data @page.blobs[params[:part]], :disposition => disposition, :type => mime_type
    else
      # Request is for the main page, it will be formatted
      @formatter = params[:formatter] || Page.type(@page.main_part)
      # Uses default render
    end
  end

  def index
    # TODO pagination
    category = params[:category]
    date_range = params[:date_range]

    if category
      @title = "All posts in category \"#{category}\""
      @pages = Page.in_category(category)
    elsif date_range
      @title = "All posts in date range \"#{date_range}\""
      @pages = Page.in_date_range(date_range)
    else
      @title = "Recent posts"
      @pages = Page.recent_posts(10)
    end

    respond_to do |format|
      format.html
      format.atom
    end
  end

end
