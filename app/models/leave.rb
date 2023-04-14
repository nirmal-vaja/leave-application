class Leave < ApplicationRecord
  belongs_to :employee, class_name: "User", foreign_key: :user_id

  validates :start_date, presence: true
  validates :subject, presence: true
  validates :description, presence: true

  enum :status, %i(pending accepted rejected)
  enum :type, %i(cl sl lwp)

  def time
    created_at.to_fs(:time)
  end

  def day
    created_at.strftime("%A")
  end

  def date
    created_at.to_date.to_s
  end
end
