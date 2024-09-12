class User < ApplicationRecord
  validates :firstname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :nickname, presence: true, uniqueness: true
  has_secure_password

  before_create :gen_nickname

  def tracking_login
    self.last_login_datetime = Time.now
    self.count_login = self.count_login + 1
  end

  private

  def gen_nickname
    self.nickname = "#{self.firstname}#{SecureRandom.random_bytes(6)}" unless self.nickname
  end
end
