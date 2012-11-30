# Generated in Section 5.4.2 by "rails generate integration_test user_pages"
require 'spec_helper'

describe "UserPages" do

  #describe "GET /user_pages" do
  #  it "works! (now write some real specs)" do
  #    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #    get user_pages_index_path
  #    response.status.should be(200)
  #  end
  #end

  # Listing 5.31 - modified to be "pretty"
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    it { should have_selector('h1', text:'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  # Listing 7.9
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
end
