require 'rails_helper'

describe User do

  it "has a valid factory" do
    expect(FactoryGirl.build(:assignee)).to be_valid
  end

  context "a new assignee" do
    subject { FactoryGirl.build(:assignee) }

    it "is invalid without a first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is invalid without a last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end
  end

  context "a user completing their details" do
    subject { FactoryGirl.build_stubbed(:user, :with_details)}

    it "has a valid factory" do
      expect(subject).to be_valid
    end

    it "must enter a citizenship" do
      subject.citizenship = nil
      expect(subject).to_not be_valid
    end

    it "must enter a date of birth" do
      subject.date_of_birth = nil
      expect(subject).to_not be_valid
    end

    it "must enter a phone number" do
      subject.phone_number = nil
      expect(subject).to_not be_valid
    end

    it "must enter an address" do
      subject.address_line_1 = nil
      expect(subject).to_not be_valid
    end

    it "must enter a city" do
      subject.city = nil
      expect(subject).to_not be_valid
    end

    it "must enter a postcode" do
      subject.postcode = nil
      expect(subject).to_not be_valid
    end
  end

  it "has many guardians" do
    expect(User.reflect_on_association(:guardians).macro).to eql(:has_many)
  end

  it "has many recipients" do
    expect(User.reflect_on_association(:recipients).macro).to eql(:has_many)
  end

  it "has many proofs" do
    expect(User.reflect_on_association(:proofs).macro).to eql(:has_many)
  end

  it "has many notes" do
    expect(User.reflect_on_association(:notes).macro).to eql(:has_many)
  end

  describe '#full_name ' do
    it "returns a user's full name" do
      subject.first_name = 'John'
      subject.last_name = 'Smith'
      expect(subject.full_name).to eql("John Smith")
    end
  end
end
