class Event < ApplicationRecord
  has_many :attendances, foreign_key: 'attended_event_id'
  has_many :attendees, through: :attendances, source: :attendee
  belongs_to :creator, class_name: 'User'

  scope :past_events, -> { where('date < ?', Date.today).order('date DESC') }
  scope :future_events, -> { where('date >= ?', Date.today).order('date ASC') }


  def future?
    date >= Date.today
  end
end
