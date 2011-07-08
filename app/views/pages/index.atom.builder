atom_feed do |feed|
  feed.title("#{BALISONG['site_title']}: #{@title}")
  feed.updated(@pages.first.date)

  for p in @pages
    feed.entry(p) do |entry|
      entry.title(p.title)
      entry.content(preview_page(p), :type => 'html')
      # Should we support author? Need a default value.
    end
  end
end

