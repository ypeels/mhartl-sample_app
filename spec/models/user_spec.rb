# Annotations generated using 'bundle exec annotate'
# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  # Listing 6.8
  before { @user = User.new(name: "Example User", email: "user@example.com") }
  subject { @user }
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  # Listing 6.11
  it { should be_valid }
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  # Listing 6.12
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  # Listing 6.14 - arbitrarily set max # chars = 50 for name
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end


end
