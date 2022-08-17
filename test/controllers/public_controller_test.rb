require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_index_url
    assert_response :success
  end

  test "should get privacy" do
    get public_privacy_url
    assert_response :success
  end

  test "should get conditions" do
    get public_conditions_url
    assert_response :success
  end
end
