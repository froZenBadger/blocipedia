require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :new => "MyString",
      :show => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_new[name=?]", "user[new]"

      assert_select "input#user_show[name=?]", "user[show]"
    end
  end
end
