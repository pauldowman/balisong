class PagesController < ApplicationController

  def show
    # convert '/' characters in id to '-'
    id = Page.de_urlify(params[:id])

    # TODO render 404 page if Page not found
    @page = Page.find(id)
    if params[:part]
      # Request is for a part, it will be sent unformatted
      if params[:download]
        disposition = 'attachment'
        mime_type = 'application/octet-stream'
      else
        disposition = 'inline'
        mime_type = MIME::Types.type_for(params[:part]).first.content_type
      end
      # TODO render 404 page if Page doesn't have a blob with that name
      send_data @page.blobs[params[:part]], :disposition => disposition, :type => mime_type
    else
      # Request is for the main page, it will be formatted
      @formatter = params[:formatter] || Page.type(@page.main_part)
      # Uses default render
    end
  end

  def index
    category = params[:category]
    date_range = params[:date_range]

    if category
      @title = category
      @pages = Page.in_category(category)
    elsif date_range
      @title = "All posts in \"#{date_range}\""
      @pages = Page.in_date_range(date_range)
    end

    @pages = @pages.sort {|a,b| (b.date || Date.new) <=> (a.date || Date.new) }
  end
end
