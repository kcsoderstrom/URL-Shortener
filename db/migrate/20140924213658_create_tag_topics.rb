class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic

      t.timestamps
    end

    add_index :tag_topics, :topic, unique: true
  end
end
