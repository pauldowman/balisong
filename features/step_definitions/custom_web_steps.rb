When /^(?:|I )go to the path "(.+)"$/ do |path|
  visit path
end

Given /^(?:|I )am on the path "(.+)"$/ do |page_name|
  visit path_to(page_name)
end

Then /^The page title should include "([^"]*)"/ do |title|
  page.should have_xpath('//head/title', :text => title)
end

Then /^I should see the image "(.+)"$/ do |image_path|
  page.should have_xpath(".//img[@src='#{image_path}']")
end

Then /^I should see a link to "(.+)" with text "(.+)"$/ do |url, text|
  page.should have_xpath(".//a[@href='#{url}']", :text => text)
end

Then /^the response should match the content of the file "(.+)"$/ do |filename|
  full_path = File.join(Rails.root, "features", "bindata", filename)
  expected = open(full_path, "rb") {|io| io.read }
  source.should == expected
end

Then /^the browser should be told to display the response as a JPEG image$/ do
  page.response_headers["Content-Type"].should == "image/jpeg"
  page.response_headers["Content-Disposition"].should == "inline"
end

Then /^the browser should be told to save the response as a file$/ do
  page.response_headers["Content-Type"].should == "application/octet-stream"
  page.response_headers["Content-Disposition"].should == "attachment"
end

Then /^I should see the following list of links with css id "(.+)":$/ do |id, table|
  table.diff!(tableish("ul##{id} li a", lambda{|el| [el, el.attribute('href')]}))
end

Then /^(?:|I )should see "([^"]*)"(?: within (.*))?$/ do |text, selector|
  with_scope(selector) do
    page.should have_content(text)
  end
end

Then /^the HTTP status code should be "([^"]*)"$/ do |status|
  page.status_code.should == status.to_i
end

