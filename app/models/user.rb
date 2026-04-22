class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:email]
  
  has_many :purchases, dependent: :destroy
  has_many :tickers, dependent: :destroy
  has_many :participations
  has_many :promotions, through: :participations
  before_create :set_uuid

  def best_ticker
    valid_tickers = tickers.where(deleted_at: nil)
    ticker = valid_tickers.where(off_type: :discount).order(rate: :desc).first
    ticker || valid_tickers.order(rate: :desc).first
  end

  private

  def set_uuid
    loop do
      new_id = SecureRandom.alphanumeric(6).upcase
      self.uuid = new_id
      break unless User.exists?(uuid: new_id)
    end
  end
end
