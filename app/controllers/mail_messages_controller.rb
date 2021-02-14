require 'json'
class MailMessagesController < ApplicationController
  p 'called'
  skip_before_action :verify_authenticity_token
  def inbound
    data = mail_params
    header = data[:Header]
    body = data[:Body]

    email = header[:From].first.match(/<(.+)>/).captures.first
    user = User.find_by(email: email)

    msg = MailMessage.new(
     subject: header[:Subject],
     from: email,
     message_id: header["Message-Id"],
     date: header[:Date],
     user: user,
     body: body,
     header: header.to_json,
    )

    msg.save!
    render_json :created
  end

  def mail_params
    params.permit(:Body, :Header => {
      :Cc => [],
      :From => [],
      "Message-Id" => [],

      Date: [],
      "In-Reply-To": [],
      "References": [],
      To: [],
      Subject: [],
      "Return-Path": []
    })
  end

end
