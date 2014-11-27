require "rails_helper"

RSpec.describe TripMailer, :type => :mailer do
  describe "data_update_notification" do
    let(:mail) { TripMailer.data_update_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Data update notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
