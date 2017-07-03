require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :new => "New",
      :show => "Show"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/New/)
    expect(rendered).to match(/Show/)
  end
end
