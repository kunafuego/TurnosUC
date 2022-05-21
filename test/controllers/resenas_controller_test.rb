require 'test_helper'

class ResenasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get resenas_index_url
    assert_response :success
  end

  test "should get show" do
    get resenas_show_url
    assert_response :success
  end

  test "should get new" do
    get resenas_new_url
    assert_response :success
  end

  test "should get edit" do
    get resenas_edit_url
    assert_response :success
  end

  test "should get create" do
    get resenas_create_url
    assert_response :success
  end

  test "should get update" do
    get resenas_update_url
    assert_response :success
  end

  test "should get destroy" do
    get resenas_destroy_url
    assert_response :success
  end

end
