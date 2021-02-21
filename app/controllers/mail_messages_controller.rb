require 'json'
class MailMessagesController < ApplicationController
  p 'called'
  skip_before_action :verify_authenticity_token
  def inbound
    data = mail_params
    header = data[:Header]
    body = data[:Body]
    patch = data[:Patch]

    email = header[:From].first.match(/<(.+)>/).captures.first
    user = User.find_by(email: email)

    msg_id = header["Message-Id"].first.match(/<(.+)>/).captures.first

    reply_to = header["In-Reply-To"]&.first&.match(/<(.+)>/)&.captures&.first
    parent_msg = MailMessage.find_by(message_id: reply_to)
    msg = MailMessage.new(
      subject: header[:Subject].first,
      thread_parent: parent_msg,
      from: email,
      message_id: msg_id,
      date: header[:Date].first,
      user: user,
      body: body,
      header: header.to_json,
      to: header[:To].first,
      patch: patch
    )

    msg.save!
    render json: msg
  end

  def mail_params
    params.permit(:Body, :Patch, :Header => {
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
