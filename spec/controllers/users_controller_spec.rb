require "rails_helper"

RSpec.describe UsersController do

  context "With no users in the database" do
    it "Can create the first administrative user" do
      post :create, params: {user: { email: "test@example.com", password: "example" }}
      expect(response).to redirect_to("/projects")
      expect(User.count).to eq 1
      expect(User.first.valid_password?("example")).to be true
    end
  end

  context "If a user already exists" do
    before { User.create(email: "test@test.com", password: "password")}
    it "Redirects to the login page" do
      expect(User.count).to eq 1
      post :create, params: {user: { email: "test@example.com", password: "example" } }
      expect(User.count).to eq 1
      expect(response).to redirect_to "/users/sign_in"
    end
  end
end
