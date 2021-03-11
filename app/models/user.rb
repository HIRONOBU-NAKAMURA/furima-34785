class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates  :password, :password_confirmation, format: { with:  /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/i }

  VALID_NAME = /\A[ぁ-んァ-ヶ一-龥々]+\z/
  validates :last_name, presence: true, format: { with: VALID_NAME }
  validates :first_name, presence: true,
                         format: { with: VALID_NAME }
  VALID_KANA_NAME = /\A[ァ-ヶー－]+\z/
  validates :kana_last_name, presence: true,
                             format: { with: VALID_KANA_NAME }
  validates :kana_first_name, presence: true,
                              format: { with: VALID_KANA_NAME }
  validates :birthday, presence: true
end
