module PagesHelper

  @@skip = [ :image, :download ]

  # Render a part as HTML. Name is the filename of the part, and formatter is
  # the name of the formatter that will be used to render the part as HTML,
  # something like "code" or "html" or "code(ruby)".
  # If formatter is nil it will be guessed based on the file extension.
  def render_part(page, part_name, formatter)
    if formatter.nil?
      formatter = Page.type(part_name)
      formatter_arg = nil
    elsif formatter =~ /(.*)\(([^\)]+)\)?/
      formatter = $1
      formatter_arg = $2
    else
      formatter = formatter
      formatter_arg = nil
    end

    raw_data = page.blobs[part_name]
    raise "Can't find part '#{part_name}'" unless raw_data

    # Render sub-parts recursively
    unless @@skip.include? formatter.to_sym
      # match {{ file.md }} or {{file.rb | code(ruby)}}, etc.
      regex = /\{\{\s*([\w\.-]+)\s*\|?\s*([\w\.-]+\(?[\w\.-]*\)?)?\s*\}\}/
      raw_data = raw_data.gsub(regex) {|match| render_part(page, $1, $2) }
    end

    Rails.logger.info "Rendering part: #{page}/#{part_name} with formatter #{formatter} (with arg: #{formatter_arg})"

    # these should be extracted somewhere to be extensible
    case formatter
    when "markdown"
      out = RDiscount.new(raw_data).to_html
    when "textile"
      out = RedCloth.new(raw_data).to_html
    when "html"
      out = raw_data
    when "text"
      out = "<pre>#{html_escape(raw_data)}</pre>"
    when "code"
      lang = formatter_arg || Page.type(part_name)
      out = "<pre class='brush: #{lang}'>#{html_escape(raw_data)}</pre>"
    when "image"
      # TODO use url_for here
      out = "<img src='/#{page.id}/#{part_name}'>"
    when "download"
      # TODO use url_for here
      out = link_to(part_name, "/#{page.id}/#{part_name}?download=true")
    else
      raise "unknown formatter: #{formatter}"
    end

    return out
  end

end

