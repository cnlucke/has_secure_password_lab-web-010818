class User < ActiveRecord::Base
  validate :must_match

  def must_match
    if password_confirmation
      errors.add(:base, 'Password and Confirmation do not match') unless password == password_confirmation
    end
  end

  def password=(new_password)
    self.password_digest = new_password
  end

  def password
    password_digest
  end

  def authenticate(password)
    return nil unless self.password_digest == password
    self
  end

end
