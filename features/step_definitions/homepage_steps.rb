Then /^I should see the following post previews:$/ do |table|
  within :css, '#recent-posts' do
    table.hashes.each_with_index do |row, i| 
      # can't seem to get this working as a CSS selector, nth-of-type
      # doesn't seem to work, does Capybara support CSS3 selectors?
      within :xpath, %{//div[@class="post-preview" and position()=#{i+1}]} do
        page.should have_css(%{h3 a[href="#{row['path']}"]}, :text => row['title'])
        page.should have_css('p', :text => row['content'])
      end
    end
  end
end

