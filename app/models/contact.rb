class Contact < ApplicationRecord
  validate :name, presence: true
  validate :content, presence: true
end
