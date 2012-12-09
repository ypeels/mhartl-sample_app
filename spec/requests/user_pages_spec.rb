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

  # Listing 7.16
  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do # signup information is blank unless specified otherwise
        expect { click_button submit }.not_to change(User, :count) # invalid user should not get committed to db
      end                                                          # {} syntax for change() invocation
                                                                   # User.count computed before and after {}
      # Listing 7.31 + Exercise 7.2
      describe "after submission" do
        before { click_button submit }
  
        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }

        # my additions
        # it { should have_content('Password digest can\'t be blank') } # Removed in Exercise 7.3!
        it { should have_content('Name can\'t be blank') }
        it { should have_content('Email can\'t be blank') }
        it { should have_content('Email is invalid') }
        it { should have_content('Password can\'t be blank') }
        it { should have_content('Password is too short (minimum is 6 characters)') }
        it { should have_content('Password confirmation can\'t be blank') }

      end

    end                                                            

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User" # (supposedly) valid signup information
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      # Listing 7.32 + Exercise 7.4
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }

        # Listing 8.26 - polish: should be signed in after signing up
        it { should have_link 'Sign out' }

      end
    end

  end # signup

  # Listing 9.1
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
  end

end # UserPages
