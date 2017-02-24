require 'rails_helper'

feature 'Partner Create Page', js: false do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user, :scope => :user)
    visit "/users/#{user.id}/assignees/new.Partner"
  end

  it 'can be reached' do
    expect(page.status_code).to eq(200)
  end

  # it 'has a profile picture upload field' do
  #   expect(page).to have_field('assignee_profile_picture', type: 'file')
  # end

  it 'type is recipient' do
    expect(find('#set_assignee_type', :visible => false).value).to eq('Recipient')
  end

  it 'relationship is partner' do
    expect(find('#assignee_relationship', :visible => false).value).to eq('Partner')
  end

  it 'has an e-mail field' do
    expect(page).to have_field('assignee_email')
  end

  it 'has a title field' do
    expect(page).to have_field('assignee_title')
  end

  it 'has a first name field' do
    expect(page).to have_field('assignee_first_name', type: 'text')
  end

  it 'has a middle name field' do
    expect(page).to have_field('assignee_middle_name', type: 'text')
  end

  it 'has a last name field' do
    expect(page).to have_field('assignee_last_name', type: 'text')
  end

  it 'has a citizenship field' do
    expect(page).to have_field('assignee_citizenship')
  end

  it 'has a date of birth field' do
    expect(page).to have_field('assignee_date_of_birth', type: 'date')
  end

  it 'has a phone number field' do
    expect(page).to have_field('assignee_phone_number', type: 'tel')
  end

  it 'has an address field' do
    expect(page).to have_field('user_address', type: 'text')
    expect(page).to have_field('assignee_address_line_2', type: 'text')
  end

  it 'has a city field' do
    expect(page).to have_field('assignee_city', type: 'text')
  end

  it 'has a postcode field' do
    expect(page).to have_field('assignee_postcode', type: 'text')
  end

  scenario 'user can fill in all their details' do
    assignee_fills_in_details
    click_on 'Save'
    # expect(page).to be('users/assignee_id/profile')
    expect(page).to have_content('My Children')
  end

  # scenario 'user can upload a profile picture' do
  #   assignee_uploads_profile_picture
  #   click_on 'Save'
  #   # expect(page).to be('users/assignee_id/profile')
  #   expect(page).to have_content('My Details')
  # end

  private

  def assignee_fills_in_details
    select "Mr", from: "assignee_title"
    fill_in 'assignee_email', with: 'test@example.com'
    fill_in 'assignee_first_name', with: 'John'
    fill_in 'assignee_last_name', with: 'Smith'
    select "French", from: "assignee_citizenship"
    fill_in 'assignee_date_of_birth', with: '31/07/1980'
    fill_in 'assignee_phone_number', with: '07123 123123'
    fill_in 'user_address', with: '12 Example Road'
    fill_in 'assignee_address_line_2', with: 'New Example'
    fill_in 'assignee_city', with: 'Exampleville'
    fill_in 'assignee_postcode', with: 'EX14 MPL'
    fill_in 'assignee_date_of_birth', with: '31/07/1980'
  end

  # def assignee_uploads_profile_picture
  #   click_on 'Change Picture'
  #   attach_file 'assignee_profile_picture', 'spec/files/eu.png'
  # end
end
