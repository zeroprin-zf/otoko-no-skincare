require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get items" do
    get public_items_url
    assert_response :success
  end

  test "should get new" do
    get public_new_url
    assert_response :success
  end

  test "should get show" do
    get public_show_url
    assert_response :success
  end

  test "should get index" do
    get public_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_edit_url
    assert_response :success
  end
end
