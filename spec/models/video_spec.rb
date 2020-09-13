require "rails_helper"

RSpec.describe Video, type: :model do
  let (:video) { build :video }

  subject { video }

  describe "Test validations" do
    context "when link is blank" do
      before { subject.link = " " }
      it { is_expected.not_to be_valid }
    end

    context "when link is empty" do
      before { subject.link = "" }
      it { is_expected.not_to be_valid }
    end

    context "when link is nil" do
      before { subject.link = nil }
      it { is_expected.not_to be_valid }
    end

    context "when link is invalid" do
      before { subject.link = "invalid" }
      it { is_expected.not_to be_valid }
    end

    context "when link is valid" do
      let (:user) {
        create :user,
        email: "email_test_#{Time.now.to_i}@test.test",
        password: "12345678"
      }

      before do
        subject.link = "https://www.youtube.com/watch?v=0gLlk4zmZAk"
        subject.user = user
      end
      it { is_expected.to be_valid }
    end
  end
end
