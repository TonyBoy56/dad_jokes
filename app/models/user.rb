class User < ApplicationRecord
  attr_accessor :password

  validates_confirmation_of :password
  validates :password, :format => {:with => /\A(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,}\z/, 
  message: "must be at least 8 characters and include one number, one letter, and a special character."}
  validates :email, 
    :presence => true,
    :uniqueness => true, 
    confirmation: { case_sensitive: false }
  validates :name, 
    :presence => true, 
    confirmation: { case_sensitive: false }
  before_save :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
  end

  def self.authenticate(email, password)
    user = User.find_by "email = ?", email
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end