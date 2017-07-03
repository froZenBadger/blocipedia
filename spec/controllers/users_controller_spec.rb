require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:new_user_attributes) do
    {
        email: "blochead@bloc.io",
        password: "password",
    }
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instantiates a new user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end


  describe "POST create" do
    it "returns an http redirect" do
      post :create, user: new_user_attributes
      expect(response).to have_http_status(:redirect)
    end

    it "creates a new user" do
      expect{
        post :create, user: new_user_attributes
      }.to change(User, :count).by(1)
    end

    it "sets user email properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end

    it "sets user password properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end

    it "logs the user is after sign up" do
      post :create, user: new_user_attributes
      expect(user_session[:user_id]).to eq assigns(:user).id
    end
  end

  describe "not signed in" do
    let(:factory_user) { create(:user) }

    before do
      post :create, user: new_user_attributes
    end

    it "returns http success" do
      get :show, {id: factory_user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: factory_user.id}
      expect(response).to render_template :show
    end

    it "assigns factory_user to @user" do
      get :show, {id: factory_user.id}
      expect(assigns(:user)).to eq(factory_user)
    end
  end
end
  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }

  # # This should return the minimal set of values that should be in the session
  # # in order to pass any filters (e.g. authentication) defined in
  # # UsersController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

#   describe "GET #index" do
#     it "returns a success response" do
#       user = User.create! valid_attributes
#       get :index, {}, valid_session
#       expect(response).to be_success
#     end
#   end
#
#   describe "GET #show" do
#     it "returns a success response" do
#       user = User.create! valid_attributes
#       get :show, {:id => user.to_param}, valid_session
#       expect(response).to be_success
#     end
#   end
#
#   describe "GET #new" do
#     it "returns a success response" do
#       get :new, {}, valid_session
#       expect(response).to be_success
#     end
#   end
#
#   describe "GET #edit" do
#     it "returns a success response" do
#       user = User.create! valid_attributes
#       get :edit, {:id => user.to_param}, valid_session
#       expect(response).to be_success
#     end
#   end
#
#   describe "POST #create" do
#     context "with valid params" do
#       it "creates a new User" do
#         expect {
#           post :create, {:user => valid_attributes}, valid_session
#         }.to change(User, :count).by(1)
#       end
#
#       it "redirects to the created user" do
#         post :create, {:user => valid_attributes}, valid_session
#         expect(response).to redirect_to(User.last)
#       end
#     end
#
#     context "with invalid params" do
#       it "returns a success response (i.e. to display the 'new' template)" do
#         post :create, {:user => invalid_attributes}, valid_session
#         expect(response).to be_success
#       end
#     end
#   end
#
#   describe "PUT #update" do
#     context "with valid params" do
#       let(:new_attributes) {
#         skip("Add a hash of attributes valid for your model")
#       }
#
#       it "updates the requested user" do
#         user = User.create! valid_attributes
#         put :update, {:id => user.to_param, :user => new_attributes}, valid_session
#         user.reload
#         skip("Add assertions for updated state")
#       end
#
#       it "redirects to the user" do
#         user = User.create! valid_attributes
#         put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
#         expect(response).to redirect_to(user)
#       end
#     end
#
#     context "with invalid params" do
#       it "returns a success response (i.e. to display the 'edit' template)" do
#         user = User.create! valid_attributes
#         put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session
#         expect(response).to be_success
#       end
#     end
#   end
#
#   describe "DELETE #destroy" do
#     it "destroys the requested user" do
#       user = User.create! valid_attributes
#       expect {
#         delete :destroy, {:id => user.to_param}, valid_session
#       }.to change(User, :count).by(-1)
#     end
#
#     it "redirects to the users list" do
#       user = User.create! valid_attributes
#       delete :destroy, {:id => user.to_param}, valid_session
#       expect(response).to redirect_to(users_url)
#     end
#   end
#
# end
