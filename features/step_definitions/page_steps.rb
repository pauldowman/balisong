Given /the following pages:$/ do |pages|
  # convert comma-separated categories into arrays
  pages.hashes.map{|p| p[:categories] = p.delete('categories').split(/,\s*/) if p['categories'] }

  # convert the body part into blobs['main.md']
  pages.hashes.map{|p| p[:blobs] = {'main.md' => p.delete('body')} if p['body'] }

  # convert the site_menu_position to an integer
  pages.hashes.map{|p| p[:site_menu_position] = p['site_menu_position'].blank? ? nil : p.delete('site_menu_position').to_i }

  Page.create!(pages.hashes)
  Then %{there should be #{pages.hashes.length} pages}
end

And /the page with id "(.+)" has part "(.+)" with content "(.+)"$/ do | id, part_name, content |
  p = Page.find(id)
  p.blobs[part_name] = content
  p.save!
end

And /the page with id "(.+)" has part "(.+)" with content:$/ do | id, part_name, content |
  p = Page.find(id)
  p.blobs[part_name] = content
  p.save!
end

And /the page with id "(.+)" has part "(.+)" with content from file "(.+)"$/ do | id, part_name, filename |
  full_path = File.join(Rails.root, "features", "bindata", filename)
  p = Page.find(id)
  p.blobs[part_name] = open(full_path, "rb") {|io| io.read }
  p.save!
end

Then /^there should be (.+) pages$/ do |n|
  Page.find_all.count.should == n.to_i
end

