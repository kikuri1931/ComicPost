require 'test_helper'

class PictureContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get picture_contents_show_url
    assert_response :success
  end

  test "should get edit" do
    get picture_contents_edit_url
    assert_response :success
  end

end
