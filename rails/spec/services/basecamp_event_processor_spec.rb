require 'rails_helper'

RSpec.describe BasecampEventProcessor do
  let(:processor) { BasecampEventProcessor.new(event_data) }
  let(:people) { JSON.parse(File.read("spec/data/basecamp_people.json")) }
  let!(:project) { Project.create(basecamp_bucket_id: "8011207") }
  let(:basecamp_client) { double("BasecampClient", people: people)}

  before do
    allow(processor).to receive(:basecamp_client) { basecamp_client }
  end

      around do |example|
      Timecop.freeze(DateTime.civil(2022, 1, 17, 14, 0, 0)) do
        example.run
      end
    end

  context "Creating a new Message Thread" do
    let(:event_data) { JSON.parse(File.read("spec/data/basecamp_message_created.json")) }


    before do
      expect(basecamp_client).to receive(:create_todo).with({
        assigned_to: [4752027],
        due_date: Date.civil(2022, 1, 18),
        source: "https://3.basecamp.com/3439565/buckets/8011207/messages/4538288296",
        text: "do something"
      })

      processor.process
    end

    it "finds the action item section" do
      expect(processor.find_action_items).to eq([{
        mentions: ["BAh7CEkiCGdpZAY6BkVUSSIoZ2lkOi8vYmMzL1BlcnNvbi80NzUyMDI3P2V4cGlyZXNfaW4GOwBUSSIMcHVycG9zZQY7AFRJIg9hdHRhY2hhYmxlBjsAVEkiD2V4cGlyZXNfYXQGOwBUMA==--7fc18eba620dd6e51ac7613330d9e302b0ba0346"],
        text: "do something tomorrow"
      }])
    end

    it "Associates the appropriate project" do
      expect(processor.project).to eq project
    end
  end

  context "commenting on a todo" do
    let(:event_data) { JSON.parse(File.read("spec/data/basecamp_comment_multiple_todos.json")) }

    it "Adds two new TODOs" do
      expect(basecamp_client).to receive(:create_todo).with({
        assigned_to: [4752027],
        due_date: Date.civil(2022, 1, 20),
        source: "https://3.basecamp.com/3439565/buckets/8011207/messages/4538288296#__recording_4538479728",
        text: "deploy gatewood"
      })

      expect(basecamp_client).to receive(:create_todo).with({
        assigned_to: [4901571, 4901558],
        due_date: Date.civil(2022, 1, 18),
        source: "https://3.basecamp.com/3439565/buckets/8011207/messages/4538288296#__recording_4538479728",
        text: "check this thing out"
      })

      processor.process
    end
  end
end