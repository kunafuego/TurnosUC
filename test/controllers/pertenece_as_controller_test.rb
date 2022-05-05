require 'test_helper'

class PerteneceAsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get pertenece_as_create_url
    assert_response :success
  end

end
