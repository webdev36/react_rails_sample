class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.text :title
      t.text :caption
      t.datetime :scheduled_at
      t.text :link
      t.integer :user_id
      t.text :slug

      t.timestamps
    end

    add_index :events, :title
  end
end
