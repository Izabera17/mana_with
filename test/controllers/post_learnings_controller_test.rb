require "test_helper"

class PostLearningsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get post_learnings_new_url
    assert_response :success
  end

  test "should get index" do
    get post_learnings_index_url
    assert_response :success
  end

  test "should get show" do
    get post_learnings_show_url
    assert_response :success
  end

  test "should get edit" do
    get post_learnings_edit_url
    assert_response :success
  end
end
