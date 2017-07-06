require 'rails_helper'

RSpec.describe "charges/new", type: :view do
  before(:each) do
    assign(:charge, Charge.new())
  end

  it "renders new charge form" do
    render

    assert_select "form[action=?][method=?]", charges_path, "post" do
    end
  end
end
