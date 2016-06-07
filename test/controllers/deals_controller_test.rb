require 'test_helper'

class DealsControllerTest < ActionController::TestCase

  def setup
    @deal = deals(:personal)
  end

  test "debe redireccionar un create no logueado" do
    assert_no_difference 'Deal.count' do
      #post :create, deal: { fuente: "fuente", producto: "producto", empresa: "empresa", estado: "estado" }
      post :create, deal: @deal
    end
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar un destroy no logueado" do
    assert_no_difference 'Deal.count' do
      delete :destroy, id: @deal.id
    end
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar un show no logueado" do
    get :show, id: @deal.id
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar un edit no logueado" do
    get :edit, id: @deal.id
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar un index no logueado" do
    get :index
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar un update no logueado" do
    patch :update, id: @deal.id, deal: { empresa: @deal.empresa, producto: @deal.producto, estado: @deal.estado, fuente: "llamada" }
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar destroy para un deal incorrecto" do
    log_in_as(users(:archer))
    assert_no_difference 'Deal.count' do
      delete :destroy, id: @deal
    end
    assert_redirected_to root_url
  end

  test "debe eliminar un deal si el usuario es un admin" do
    admin = users(:michael)
    log_in_as(admin)
    assert_difference 'Deal.count', -1 do
      delete :destroy, id: @deal
    end
    assert_redirected_to root_url
  end
    
  test "debe eliminar un deal si le pertenece al usuario" do
    owner = users(:lana)
    log_in_as(owner)
    assert_difference 'Deal.count', -1 do
      delete :destroy, id: @deal
    end
    assert_redirected_to root_url
  end

  test "debe redireccionar update para un deal incorrecto de un non-admin" do
    log_in_as(users(:lana))
    deal = deals(:claro)
    deal2 = deal.dup
    patch :update, id: deal, deal: deal2
    assert_redirected_to root_url
  end

end
