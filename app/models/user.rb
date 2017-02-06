class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attachment :profile_picture

  has_many :assignees, dependent: :destroy
    has_many :guardians, dependent: :destroy
    has_many :recipients, dependent: :destroy
  has_many :proofs, dependent: :destroy
  has_many :notes, dependent: :destroy

  def details_completed?
    true if first_name && last_name && profile_picture && citizenship && date_of_birth && email && phone_number && address_line_1 && address_line_2 && town && postcode && country
  end

  def full_name
    middle_name ? first_name + " " + middle_name + " " + last_name : first_name + " " + last_name
  end

  def name_surname
    first_name + " " + last_name
  end

  # Relationship Methods
  def partner
    recipients.where('relationship = ?', 'Partner').first
  end

  def children
    recipients.where('relationship = ?', 'Child')
  end

  def show_other
    recipients.where(['relationship != ? AND relationship != ?', 'Partner', 'Child'])
  end

  def show_other_family
    recipients.where('relationship != ? AND relationship != ? AND relationship != ?',
     'Friend', 'Partner', 'Child')
  end

  def show_mother
    recipients.where('relationship = ?', 'Mother')
  end

  def show_friends
    recipients.where('relationship = ?', 'Friend')
  end

  # Validations
  attr_accessor :current_step

  def current_step?(step_key)
    current_step.blank? || current_step == step_key
  end

  validates :first_name, presence: :true, if: 'current_step?(:basic_profile)'
  validates :last_name, presence: :true, if: 'current_step?(:basic_profile)'

  validates :address_line_1, presence: :true, if: 'current_step?(:contact_info)'
  validates :town, presence: :true, if: 'current_step?(:contact_info)'
  validates :country, presence: :true, if: 'current_step?(:contact_info)'
  validates :postcode, presence: :true, if: 'current_step?(:contact_info)'
end
