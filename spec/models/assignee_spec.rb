require 'rails_helper'

describe Assignee do

  it "has a valid factory" do
    expect(FactoryGirl.build(:assignee)).to be_valid
  end

  it "belongs to a user" do
    expect(Assignee.reflect_on_association(:user).macro).to eql(:belongs_to)
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

    it "has a user" do
      subject.user = nil
      expect(subject).not_to be_valid
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

  describe '#full_name ' do
    it "returns an assignees's full name" do
      subject.first_name = 'John'
      subject.last_name = 'Smith'
      expect(subject.full_name).to eql("John Smith")
    end
  end
end
