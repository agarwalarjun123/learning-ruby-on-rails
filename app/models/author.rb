class Author < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  before_save :downcase_fields

  def downcase_fields
    name.downcase! && email.downcase!
  end

  def as_json(*)
    super.as_json.slice!('password_digest')
  end

  def generate_token
    JWT.encode({ email: }, 'string')
  end
end
