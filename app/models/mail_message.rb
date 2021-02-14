class MailMessage < ApplicationRecord
  validates_presence_of :body
  belongs_to :user
  belongs_to :thread_parent, class_name: "MailMessage", optional: true
  belongs_to :referenced_message, class_name: "MailMessage", optional: true

  has_many :thread_responses, foreign_key: :in_reply_to, class_name: "MailMessage"
  has_many :referencing_messages, foreign_key: :in_reference_to, class_name: "MailMessage"
end
