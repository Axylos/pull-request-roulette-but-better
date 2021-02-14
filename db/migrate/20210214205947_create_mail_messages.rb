class CreateMailMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_messages, id: :uuid do |t|
      t.json :header, null: false
      t.text :body, null: false

      t.references :in_reply_to, type: :uuid, foreign_key: {
        to_table: "mail_messages"
      }
      t.references :in_reference_to, type: :uuid, foreign_key: {
        to_table: "mail_messages"
      }

      t.references :user, type: :uuid, foreign_key: true
      t.text :subject, null: false
      t.text :from, null: false
      t.text :to, null: false
      t.text :date, null: false
      t.text :message_id, null: false, unique: true


      t.timestamps
    end
  end
end
