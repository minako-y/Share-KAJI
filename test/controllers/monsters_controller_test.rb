require 'test_helper'

class MonstersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get monsters_new_url
    assert_response :success
  end

  test "should get index" do
    get monsters_index_url
    assert_response :success
  end

  test "should get show" do
    get monsters_show_url
    assert_response :success
  end

  test "should get edit" do
    get monsters_edit_url
    assert_response :success
  end

end
