require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  before(:all) do
    @user = User.create(email: "toto@to.to")
  end

  describe "GET /new" do
    it "returns http success" do
      get "/session/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/session/create", params: {email: @user.email}
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE /delete" do
    it "returns http success" do
      delete "/session/delete"
      session[:user_id] = @user.id
      expect(response).to have_http_status(302)
    end
  end

end
