class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 30 }
end
