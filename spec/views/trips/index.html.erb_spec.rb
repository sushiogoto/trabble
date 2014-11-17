require 'rails_helper'

RSpec.describe "trips/index", :type => :view do
  before(:each) do
    assign(:trips, [
      Trip.create!(
        :location => "Location"
      ),
      Trip.create!(
        :location => "Location"
      )
    ])
  end

  it "renders a list of trips" do
    render
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
