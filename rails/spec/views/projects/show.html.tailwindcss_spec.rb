require 'rails_helper'

RSpec.describe "projects/show", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      name: "Name",
      basecamp_bucket_id: "Basecamp Bucket",
      basecamp_todolist_id: "Basecamp Todolist",
      slack_channel_id: "Slack Channel"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Basecamp Bucket/)
    expect(rendered).to match(/Basecamp Todolist/)
    expect(rendered).to match(/Slack Channel/)
  end
end
