require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/users/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/users", :params => { :user => {:email => "toto@to.to"} }
      expect(response).to have_http_status(302)
    end
  end
end
