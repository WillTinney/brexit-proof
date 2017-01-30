class Proof < ApplicationRecord
  belongs_to :user

  has_attachment :document
end
