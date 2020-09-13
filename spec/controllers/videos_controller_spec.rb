require "rails_helper"

RSpec.describe VideosController, type: :controller do
  YOUTUBE_LINK="https://www.youtube.com/watch?v=0gLlk4zmZAk"
  describe "Test rendering new video page" do
    context "when user logged in" do
      let (:user) {
        create :user,
        email: "email_test_#{Time.now.to_i}@test.test",
        password: "12345678"
      }
      it "should render new video page" do
        session[:user_id] = user.id
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "when user did not log in" do
      it "should render new video page" do
        session[:user_id] = nil
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "Test get list of videos" do
    context "when user logged in" do
      let (:user) {
        create :user,
        email: "email_test_#{Time.now.to_i}@test.test",
        password: "12345678"
      }
      it "should render index video page" do
        session[:user_id] = user.id
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "when user did not log in" do
      it "should render new video page" do
        session[:user_id] = nil
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe "Test create video" do
    context "when user did not log in" do
      it "should render new video page" do
        session[:user_id] = nil
        post :create, params: { link: YOUTUBE_LINK }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
