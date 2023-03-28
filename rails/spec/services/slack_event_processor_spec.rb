require 'rails_helper'

RSpec.describe SlackEventProcessor do
  let(:processor) { SlackEventProcessor.new(event_data) }
  let(:slack_client) { double("slack_client",
    people: people)}

  before do
    allow(processor).to receive(:slack_client) { slack_client }
  end

  context "for a confusing post" do
    let(:event_data) do
      {
        "token"=>"[FILTERED]",
        "team_id"=>"T025BJZ3Y",
        "api_app_id"=>"A02SZD13BPY",
        "event"=>{
          "client_msg_id"=>"3e96f731-48b6-4989-aa5c-eb019077fb9f",
          "type"=>"app_mention",
          "text"=>"<@U02T3ADPC9K> what's up",
          "user"=>"U025BJZ44",
          "ts"=>"1680043156.414809",
          "blocks"=>[{
            "type"=>"rich_text",
            "block_id"=>"Fy5t",
            "elements"=>[{
              "type"=>"rich_text_section",
              "elements"=>[{
                "type"=>"user",
                "user_id"=>"U02T3ADPC9K"
              },{
                "type"=>"text",
                "text"=>" what's up"
              }]
            }]
          }],
          "team"=>"T025BJZ3Y",
          "channel"=>"CD137QCP3",
          "event_ts"=>"1680043156.414809"
        },
        "type"=>"event_callback",
        "event_id"=>"Ev050QN4N8R1",
        "event_time"=>1680043156,
        "authorizations"=>[{
          "enterprise_id"=>nil,
          "team_id"=>"T025BJZ3Y",
          "user_id"=>"U02T3ADPC9K",
          "is_bot"=>true,
          "is_enterprise_install"=>false
        }],
        "is_ext_shared_channel"=>false,
        "event_context"=>"4-eyJldCI6ImFwcF9tZW50aW9uIiwidGlkIjoiVDAyNUJKWjNZIiwiYWlkIjoiQTAyU1pEMTNCUFkiLCJjaWQiOiJDRDEzN1FDUDMifQ"
      }
    end
    it "will reply to a confusing post with a question" do
      processor
    end
  end
end
