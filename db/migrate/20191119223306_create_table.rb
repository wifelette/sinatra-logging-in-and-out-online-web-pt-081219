class CreateTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.integer :balance
    end
  end
end
