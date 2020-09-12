require "rails_helper"

RSpec.describe User, type: :model do
  let (:user) { build :user }

  subject { user }

  describe "Test email of user model" do
    context "when email is blank" do
      before { subject.email = " " }
      it { is_expected.not_to be_valid }
    end

    context "when email is empty" do
      before { subject.email = "" }
      it { is_expected.not_to be_valid }
    end

    context "when email is nil" do
      before { subject.email = nil }
      it { is_expected.not_to be_valid }
    end

    context "when email is too long" do
      before { subject.email = "a" * 255 + "@test.com" }
      it { is_expected.not_to be_valid }
    end

    context "when email is invalid" do
      before { subject.email = "wrong format" }
      it { is_expected.not_to be_valid }
    end
  end

  describe "Test password of user model" do
    context "when password is blank" do
      before { subject.password = " " }
      it { is_expected.not_to be_valid }
    end

    context "when password is nil" do
      before { subject.password = nil }
      it { is_expected.not_to be_valid }
    end

    context "when password is too sort" do
      before { subject.password = "a" * 7 }
      it { is_expected.not_to be_valid }
    end
  end
end
