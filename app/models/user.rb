class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :attendances, foreign_key: 'event_attendee_id'
  has_many :attended_events, through: :attendances
  has_many :events, foreign_key: 'creator_id'
  # dont forget foreign_key takes a string.
  # and source is if the time is something different than expected 
end
