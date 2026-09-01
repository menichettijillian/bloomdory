class CreateSchedules < ActiveRecord::Migration[8.1]
  def change
    create_table :schedules do |t|
      t.text :description
      t.date :starting_date
      t.date :ending_date
      t.time :starting_hour
      t.time :ending_hour
      t.string :title
      t.string :category
      t.references :user, null: false, foreign_key: true


      t.timestamps
    end
  end
end
