require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :new => "MyString",
      :show => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_new[name=?]", "user[new]"

      assert_select "input#user_show[name=?]", "user[show]"
    end
  end
end
