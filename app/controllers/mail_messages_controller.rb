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
      subject: header[:Subject].first,
     from: email,
     message_id: header["Message-Id"].first,
     date: header[:Date].first,
     user: user,
     body: body,
     header: header.to_json,
     to: header[:To].first
    )

    msg.save!
    render json: msg
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
