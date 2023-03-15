class Leave < ApplicationRecord
  belongs_to :employee, class_name: "User", foreign_key: :user_id

  validates :start_date, presence: true
  validates :subject, presence: true
  validates :description, presence: true

  after_commit :count_number_of_days

  def time
    created_at.to_fs(:time)
  end

  def day
    created_at.strftime("%A")
  end

  def date
    created_at.to_date.to_s
  end

  private

  def count_number_of_days
    number_of_days = end_date.nil? ? 1 : (end_date.to_date - start_date.to_date).to_i + 1
    update(number_of_days: number_of_days)
  end

end
