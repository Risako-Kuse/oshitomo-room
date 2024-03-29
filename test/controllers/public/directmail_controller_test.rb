require "test_helper"

class Public::DirectmailControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_directmail_new_url
    assert_response :success
  end

  test "should get index" do
    get public_directmail_index_url
    assert_response :success
  end

  test "should get show" do
    get public_directmail_show_url
    assert_response :success
  end

  test "should get create" do
    get public_directmail_create_url
    assert_response :success
  end
end
