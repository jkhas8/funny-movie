require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "Test sending login request" do
    context "when user did not have account before" do
      it "should be create new account and login" do
        email = "email_test_#{Time.now.to_i}@test.test"
        not_existed_user = User.find_by_email(email)
        expect(not_existed_user).to eq nil

        post :create, params: { email: email, password: "12345678" }
        expect(response).to redirect_to(root_path)
        expect(current_user.new_record?).to eq false
        expect(current_user.email).to eq email
        user = User.find_by_email(email)
        expect(user.email).to eq email
      end
    end

    context "when user used wrong password" do
      let (:user) {
        create :user,
        email: "email_test_#{Time.now.to_i}@test.test",
        password: "correct_password"
      }

      it "should render new tempalte" do
        post :create, params: { email: user.email, password: "wrong_password" }
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user used correct password" do
      let (:user) {
        create :user,
        email: "email_test_#{Time.now.to_i}@test.test",
        password: "12345678"
      }

      it "should render new tempalte" do
        post :create, params: { email: user.email, password: "12345678" }
        expect(response).to redirect_to(root_path)
        expect(current_user.new_record?).to eq false
        expect(current_user.email).to eq user.email
      end
    end
  end

  describe "Test sending logout request" do
    context "when user logout sucessfully" do
      let (:user) {
        create :user,
        email: "email_test_#{Time.now.to_i}@test.test",
        password: "12345678"
      }

      it "should logout and redirect to root_path" do
        post :create, params: { email: user.email, password: "12345678" }
        delete :destroy
        expect(response).to redirect_to(root_path)
        expect(current_user).to eq nil
      end
    end
  end
end
