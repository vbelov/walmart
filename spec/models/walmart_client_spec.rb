require "rails_helper"

RSpec.describe WalmartClient do
  it "should be ok" do
    reviews = WalmartClient.find_reviews(44465708)
    expect(reviews.count).to eq(17)
    expect(reviews.map(&:text).join("\n")).to match(/There is some confusion on this listing of which phone this actually is/)
  end

  it 'should filter' do
    reviews = WalmartClient.find_reviews(44465708, 'confusion listing')
    expect(reviews.count).to eq(1)
  end

  it 'should find nothing' do
    reviews = WalmartClient.find_reviews(44465708, 'confusion football')
    expect(reviews.count).to eq(0)
  end
end
