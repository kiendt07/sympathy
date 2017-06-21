class FormUser < User
  attr_accessor :current_password

  validates :email, uniqueness: true, allow_blank: true, if: :email_changed?
  validates :email, format: {with: Devise.email_regexp}, allow_blank: true,
    if: :email_changed?

  validates :password, presence: true, if: :password_required?
  validates :password, confirmation: true, if: :password_required?

  private

  def password_required?
    return false if email.blank?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
