require 'rails_helper'

RSpec.describe CommandParser do
  let(:input) { "deploy the slack bot to docker tomorrow" }
  let(:cmd) { CommandParser.parse(input) }
  context "#parse" do
    it "returns a command object" do
      expect(cmd.text).to eq "deploy the slack bot to docker"
    end
  end

  context "due dates" do
    it "knows what tomorrow means" do
      Timecop.freeze Date.civil(2022, 1, 7) do
        expect(cmd.due_date).to eq Date.civil(2022, 1, 8)
      end
    end
    it "handles days of the week" do
      Timecop.freeze Date.civil(2022, 1, 7) do # friday
        expect(CommandParser.parse("do it monday").due_date).to eq Date.civil(2022, 1, 10)
        expect(CommandParser.parse("do it tuesday").due_date).to eq Date.civil(2022, 1, 11)
        expect(CommandParser.parse("do it thursday").due_date).to eq Date.civil(2022, 1, 13)
      end
    end
  end
end