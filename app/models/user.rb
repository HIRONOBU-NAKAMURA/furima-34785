class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  valid = VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  # validates :password, format: { with: valid }
  # validates :encrypted_password,:password,:password_confirmation,format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{7,}/}
  # validates  :password, :password_confirmation, format: { with: VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i }
  validates  :password, :password_confirmation, format: { with:  /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/i }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/}
  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ }
  validates :kana_last_name, presence: true,
                             format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :kana_first_name, presence: true,
                              format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birthday, presence: true
end
