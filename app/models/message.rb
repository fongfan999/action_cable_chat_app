class Message < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  scope :for_display, -> { order(:created_at).last(50) }

  # Return a list of users @mentioned in message content
  def mentions
    User.where(username: content.scan(/@(\w+)/)
      .flatten.reject { |usn| usn == user.username })
  end
end
