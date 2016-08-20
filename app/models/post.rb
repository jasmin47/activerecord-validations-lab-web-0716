

class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :content, length: { minimum: 100}
  validates :summary, length: { maximum: 100}
  validates :category, inclusion: { in: %w(Fiction Non-Fiction),
    message: "%{value} is not a valid category"}
  validate :not_clickbait

  def not_clickbait
    click_bait = ["Won't Believe", "Secret", "Top", "Guess"]
    if self.title.nil?
    errors.add(:title, "Must have title.")
    elsif !click_bait.collect {|phrase| self.title.include?(phrase)}.any? == true
      errors.add(:title, "Not clickbait.")
    end
  end

end
