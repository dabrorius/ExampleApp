class Task < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  validates :description, presence: true
  validates :priority, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true }

  def due_at_formatted(default="Not scheduled")
    if due_at.blank?
      default
    else
      due_at.strftime("%Y/%m/%d %H:%M")
    end 
  end

end
