class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :username, null: false, unique: true
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :gh_username
    end
  end
end
