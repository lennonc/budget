class ChangeDataTypeForTransactionAmount < ActiveRecord::Migration
  def self.up
    change_table :transactions do |t|
      t.change :amount, :decimal, :precision => 10, :scale => 2
    end
  end
  def self.down
    change_table :transactions do |t|
      t.change :amount, :integer
    end
  end
end
