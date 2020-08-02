class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :attended_event
      t.references :event_attendee
      t.timestamps
    end
  end
end
