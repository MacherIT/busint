require 'test_helper'

class ComentariosControllerTest < ActionController::TestCase
  test "should get user:references" do
    get :user:references
    assert_response :success
  end

  test "should get accion:references" do
    get :accion:references
    assert_response :success
  end

  test "should get texto:text" do
    get :texto:text
    assert_response :success
  end

end
