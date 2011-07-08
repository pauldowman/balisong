module PagesHelper

  # Render a part as HTML. Name is the filename of the part, and formatter is
  # the name of the formatter that will be used to render the part as HTML,
  # something like "code" or "html" or "code(ruby)".
  # If formatter is nil it will be guessed based on the file extension.
  def render_part(page, part_name, formatter)
    if formatter.nil?
      formatter = Page.type(part_name)
      formatter_args = nil
    elsif formatter =~ /(.*)\(([^\)]+)\)?/
      formatter = $1
      formatter_args = $2
    else
      formatter = formatter
      formatter_args = nil
    end

    Rails.logger.info "Rendering part: #{page}/#{part_name} with formatter #{formatter} (with args: #{formatter_args})"

    raw_data = page.blobs[part_name]
    raise "Can't find part '#{part_name}'" unless raw_data

    # TODO this probably isn't the right thing to do here, figure out how
    # GitModel can set the correct encoding on the blob
    raw_data = raw_data.force_encoding("UTF-8")

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
      if formatter_args =~ /(.*),\s*(\d+)-(\d+)/
        # Only render specified line range of the content
        lang = $1
        first_line = $2.to_i
        last_line = $3.to_i
        range = (first_line-1..last_line-1)
        raw_data = raw_data.lines.to_a[range].join
      elsif formatter_args
        lang = formatter_args
      else
        lang = Page.type(part_name)
      end
      out = "<pre class='brush: #{lang}; first-line: #{first_line || 1} toolbar: false;'>#{html_escape(raw_data)}</pre>"
    when "image"
      # TODO use url_for here
      out = "<img src='/#{page.id}/#{part_name}'>"
      skip_sub_render = true
    when "download"
      # TODO use url_for here
      out = link_to(part_name, "/#{page.id}/#{part_name}?download=true")
      skip_sub_render = true
    else
      raise "unknown formatter: #{formatter}"
    end

    # Render sub-parts recursively
    unless skip_sub_render
      # match {{ file.md }} or {{file.rb | code(ruby)}}, or {{file.rb | code(ruby, 2-4)}}, etc.
      regex = /\{\{\s*([\w\.-]+)\s*\|?\s*([\w\.-]+\(?[^\(\}]*\)?)?\s*\}\}/
      out = out.gsub(regex) {|match| render_part(page, $1, $2) }
    end

    return out
  end

  def preview_page(page)
    length = 220
    link = link_to("Read on...", page_url(page))
    strip_tags(render_part(page, page.main_part, Page.type(page.main_part))).truncate(length, :separator => ' ', :omission => "... <span class='more-link'>#{link}</span>").html_safe
  end
end

