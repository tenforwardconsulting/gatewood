require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      name: "MyString",
      basecamp_bucket_id: "MyString",
      basecamp_todolist_id: "MyString",
      slack_channel_id: "MyString"
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input[name=?]", "project[name]"

      assert_select "input[name=?]", "project[basecamp_bucket_id]"

      assert_select "input[name=?]", "project[basecamp_todolist_id]"

      assert_select "input[name=?]", "project[slack_channel_id]"
    end
  end
end
