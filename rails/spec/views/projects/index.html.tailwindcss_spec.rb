require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  before(:each) do
    assign(:projects, [
      Project.create!(
        name: "Name",
        basecamp_bucket_id: "Basecamp Bucket",
        basecamp_todolist_id: "Basecamp Todolist",
        slack_channel_id: "Slack Channel"
      ),
      Project.create!(
        name: "Name",
        basecamp_bucket_id: "Basecamp Bucket",
        basecamp_todolist_id: "Basecamp Todolist",
        slack_channel_id: "Slack Channel"
      )
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Basecamp Bucket".to_s, count: 2
    assert_select "tr>td", text: "Basecamp Todolist".to_s, count: 2
    assert_select "tr>td", text: "Slack Channel".to_s, count: 2
  end
end
