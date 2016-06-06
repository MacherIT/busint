
require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get inicio" do
    get :inicio
    assert_response :success
    assert_select "title", "Business Intelligence"
  end

  test "should get ayuda" do
    get :ayuda
    assert_response :success
    assert_select "title", "Ayuda | Business Intelligence"
  end

end
