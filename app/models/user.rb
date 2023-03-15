class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :has_one_admin, -> { where(admin: true) }

  has_many :leaves, dependent: :destroy, class_name: "Leave"
end
