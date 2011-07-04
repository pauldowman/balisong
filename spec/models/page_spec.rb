require 'spec_helper'

describe Page do

  describe '#in_category' do
    
    it 'returns all Page objects that have the given category in the categories array' do
      Page.create!(:id => 'one', :categories => ['monkey', 'ape'])
      Page.create!(:id => 'two', :categories => ['monkey', 'gorilla'])
      Page.create!(:id => 'three', :categories => ['gorilla'])
      Page.create!(:id => 'four')
      Page.index!

      Page.in_category('monkey').map{|page| page.id}.should == ['two', 'one']
    end

  end

  describe '#in_date_range' do

    it 'returns all Page objects that have a date that falls within the given year, month, and day' do
      Page.create(:id => 'one')
      Page.create(:id => '2010-11-01-two')
      Page.create(:id => '2010-11-01-three')
      Page.create(:id => '2010-11-02-four')
      Page.create(:id => '2009-11-01-five')
      Page.index!

      Page.in_date_range('2010/11/01').map{|page| page.id}.sort.should == ['2010-11-01-two', '2010-11-01-three'].sort
    end

    it 'returns all Page objects that have a date that falls within the given year and month' do
      Page.create(:id => 'one')
      Page.create(:id => '2010-11-01-two')
      Page.create(:id => '2010-11-02-three')
      Page.create(:id => '2010-09-02-four')
      Page.create(:id => '2009-11-01-five')
      Page.index!

      Page.in_date_range('2010/11').map{|page| page.id}.sort.should == ['2010-11-01-two', '2010-11-02-three'].sort
    end


    it 'returns all Page objects that have a date that falls within the given year' do
      Page.create(:id => 'one')
      Page.create(:id => '2010-11-01-two')
      Page.create(:id => '2010-12-01-three')
      Page.create(:id => '2009-11-01-five')
      Page.index!

      Page.in_date_range('2010').map{|page| page.id}.sort.should == ['2010-11-01-two', '2010-12-01-three'].sort
    end


  end

end
