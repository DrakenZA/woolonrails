class CreateWoolentries < ActiveRecord::Migration
  def change
    create_table :woolentries do |t|
      t.float :lat
      t.float :long
      t.string :desc
      t.string :person
      t.string :phonenum
      t.references :user


      t.timestamps null: false
    end
  end
end
