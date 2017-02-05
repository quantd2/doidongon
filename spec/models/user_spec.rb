require 'rails_helper'

describe User do
  before do
    @user = User.new(email: "user@example.com", password: "stinkydog",
      password_confirmation: "stinkydog", phone: "999999999")
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:items) }
  it { should respond_to(:phone) }
  it { should be_valid }

  describe "admin should be nil by default" do
    before { @user.save  }
    it "admin should be nil by default" do
      expect(@user.admin).to eq nil
    end
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = "" }
    it { should_not be_valid }
  end

  describe "when phone is not present" do
    before { @user.phone = "" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user at foo.org example.user@foo.
        foo@bar baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to be_invalid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it "should be valid" do
      expect(@user).to be_invalid
    end
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "item associations" do
    before do
      @user.save
    end

    let!(:older_item) do
      FactoryGirl.create(:item, created_at: 1.month.ago, :user => @user)
    end

    let!(:newer_item) do
      FactoryGirl.create(:item, created_at: 1.day.ago, user: @user)
    end

    it "should have the right item in the right order" do
      expect(@user.items).to eq [newer_item, older_item]
    end
  end

  it "should destroy associated microposts" do
    items = @user.items
    @user.destroy
    items.each do |item|
      Item.find_by_id(item.id).should_be nil
    end
  end

end
