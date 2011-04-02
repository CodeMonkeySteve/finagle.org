require 'spec_helper'

describe Comic do
  for comic in [:bizarro, :non_sequitur, :zits, :user_friendly]
    before do
      @comic = Comics[comic]
    end

    it "fetches the weekday edition on #{comic}" do
      date = Date.new 2010, 4, 13
      img = @comic.fetch date
      img.format.downcase.should == 'gif'
      img.columns.should > 100
      img.rows.should > 100
    end

    it "fetches the weekend edition on #{comic}" do
      date = Date.new 2010, 4, 12
      img = @comic.fetch date
      ['gif','jpeg'].should be_include(img.format.downcase)
      img.columns.should > 100
      img.rows.should > 100
    end
  end
end
