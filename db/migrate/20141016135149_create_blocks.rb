class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :discipline
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
