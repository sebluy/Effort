class ChangeDisciplineToForeignKey < ActiveRecord::Migration

  def change
    remove_column :blocks, :discipline
    add_reference :blocks, :discipline
  end

end
