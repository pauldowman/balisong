Then /^I should see an Atom feed with the following entries:$/ do |table|
  table.hashes.each_with_index do |row, i| 
    within :xpath, %{//feed/entry[#{i+1}]} do
      page.should have_xpath(%{//link[@href="#{row['url']}"]})
      page.should have_xpath(%{//title}, :text => row['title'])
      page.should have_xpath(%{//content[@type='html']}, :text => row['content'])
    end
  end
end

Then /^I should see a valid Atom feed autodiscovery tag$/ do
  page.should have_xpath("//head/link[@href='#{posts_url(:format => :atom)}' and @rel='alternate' and @type='application/atom+xml']")
end

