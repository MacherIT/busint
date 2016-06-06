require 'test_helper'

class ProductosControllerTest < ActionController::TestCase
#  test "should get show pero no sin loguearse" do
#    get :show
#    assert_redirected_to loguearse_url
#  end

  test "should get index pero no sin loguearse" do
    get :index
    assert_redirected_to loguearse_url
  end

end
