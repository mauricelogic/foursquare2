require 'helper'

class TestVenues < Test::Unit::TestCase

  context "When using the foursquare API and working with venues" do
    setup do
      @client = foursquare_test_client
    end

    should "fetch info for a single venue" do
      stub_get("https://api.foursquare.com/v2/venues/4b8c3d87f964a520f7c532e3?oauth_token=#{@client.oauth_token}", "venue.json")
      venue = @client.venue('4b8c3d87f964a520f7c532e3')
      venue.name.should == 'Bridgestone Arena'
      venue.location.address.should == '501 Broadway'
    end

    should "search for venues based on passed criteria" do
      stub_get("https://api.foursquare.com/v2/venues/search?ll=36.142064%2C-86.816086&oauth_token=#{@client.oauth_token}&query=coffee", "search_venues.json")
      venues = @client.search_venues(:ll => "36.142064,-86.816086", :query => "coffee")
      venues.groups.first.items.first.name.should == 'Ugly Mugs'
    end

    should "search for venues from a tip search" do
      stub_get("https://api.foursquare.com/v2/tips/search?ll=-23.013968%2C-45.550802&oauth_token=#{@client.oauth_token}&query=rodoviaria", "search_venues_by_tip.json")
      venues = @client.search_venues_by_tip(:ll => "-23.013968,-45.550802", :query => "rodoviaria")
      venues.first.name.should == "Santa Barbara"
    end
  end

end
