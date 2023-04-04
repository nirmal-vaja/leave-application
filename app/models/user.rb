class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates_presence_of :first_name, :last_name, :date_of_joining, :phone_number
  validates_presence_of :pan_number, :if => Proc.new { |o| !o.admin }

  scope :has_one_admin, -> { where(admin: true) }

  has_many :leaves, dependent: :destroy, class_name: "Leave"
  has_many :bank_infos, dependent: :destroy


  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authenctication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
