class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:email]
  
  has_many :purchases, dependent: :destroy
  has_many :tickers, dependent: :destroy
  has_many :promotions, through: :tickers
  has_many :activities, through: :promotions
  has_one :store
end
