class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :confirm
      t.string :password
      t.string :name
      t.string :mobile

      t.timestamps
    end
  end
end
