require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    assign(:project, Project.new(
      name: "MyString",
      basecamp_bucket_id: "MyString",
      basecamp_todolist_id: "MyString",
      slack_channel_id: "MyString"
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input[name=?]", "project[name]"

      assert_select "input[name=?]", "project[basecamp_bucket_id]"

      assert_select "input[name=?]", "project[basecamp_todolist_id]"

      assert_select "input[name=?]", "project[slack_channel_id]"
    end
  end
end
