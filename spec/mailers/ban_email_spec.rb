require "rails_helper"

RSpec.describe BanEmailMailer, type: :mailer do
  describe "banned" do
    let(:mail) { BanEmailMailer.banned }

    it "renders the headers" do
      expect(mail.subject).to eq("Banned")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
