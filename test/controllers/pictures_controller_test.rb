require 'test_helper'

class PicturesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pictures_new_url
    assert_response :success
  end

  test "should get edit" do
    get pictures_edit_url
    assert_response :success
  end

  test "should get show" do
    get pictures_show_url
    assert_response :success
  end

end
