require 'rails_helper'

RSpec.describe "MailMessages", type: :request do
  let(:body) { File.read "./spec/test_files/first_request.txt" }
  let(:series_first) { File.read "./spec/test_files/series_first.json" }
  let(:series_second) { File.read "./spec/test_files/series_second.json" }
  before(:all) do
    User.create!(
      username: "drakey",
      email: "robertdraketalley@gmail.com",
      gh_username: "axylos",
      password: "pass",
      password_confirmation: "pass"
    )
  end

  after(:all) do
    User.find_by(email: "robertdraketalley@gmail.com")
      .destroy!
  end
               
               
  it "creates a message" do
    count = MailMessage.count
    headers = { "ACCEPT": "application/json",
                "CONTENT_TYPE": "application/json" }
    post "/messages/inbound", params: body, headers: headers

    data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(count).not_to equal(MailMessage.count)
    expect(data['patch']).to match("baz")
  end 

  it "associates with a patch series" do
    headers = { "ACCEPT": "application/json",
                "CONTENT_TYPE": "application/json" }

    post "/messages/inbound", params: series_first, headers: headers
    post "/messages/inbound", params: series_second, headers: headers


    expect(MailMessage.last.thread_parent).not_to be_nil
    data = JSON.parse(response.body)

  end

end
