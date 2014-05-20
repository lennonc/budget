class ChangeDataTypeForTransactionAmount < ActiveRecord::Migration
  def self.up
    change_table :transactions do |t|
      t.change :amount, :integer
    end
  end
  def self.down
    change_table :transactions do |t|
      t.change :amount, :decimal, :precision => 8, :scale => 2
    end
  end
end
