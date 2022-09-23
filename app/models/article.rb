class Article < ApplicationRecord
  belongs_to :author
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 100 }
end
