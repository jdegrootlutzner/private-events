class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :attended_event
      t.references :attendee
      t.boolean :status
      t.timestamps
    end
  end
end
