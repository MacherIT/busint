require 'test_helper'

class DealsControllerTest < ActionController::TestCase

  def setup
    @deal = deals(:nextel)
  end

  test "debe redireccionar un create no logueado" do
    assert_no_difference 'Deal.count' do
      post :create, deal: { fuente: "fuente", producto: "producto", empresa: "empresa", estado: "estado" }
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

end
