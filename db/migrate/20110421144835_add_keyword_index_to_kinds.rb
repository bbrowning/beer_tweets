class AddKeywordIndexToKinds < ActiveRecord::Migration
  def self.up
    add_index :kinds, [:keyword, :word, :offset]
  end

  def self.down
    remove_index :kinds, :column => [:keyword, :word, :offset]
  end
end
