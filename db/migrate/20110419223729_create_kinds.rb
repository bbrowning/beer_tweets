class CreateKinds < ActiveRecord::Migration
  def self.up
    create_table :kinds do |t|
      t.string :keyword
      t.string :word
      t.integer :offset
      t.references :beer

      t.timestamps
    end
  end

  def self.down
    drop_table :kinds
  end
end
