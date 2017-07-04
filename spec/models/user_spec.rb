require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:wikis) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe ".avatar_url" do
    let(:known_user) { create(:user, email: "blochead@bloc.io") }

    it "returns the proper Gravatar url for a known email entity" do
      expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
      expect(known_user.avatar_url(48)).to eq(expected_gravatar)
    end
  end

  describe "attributes" do
    it "should have email attributes" do
      expect(user).to have_attributes(email: user.email)
    end
  end
end
