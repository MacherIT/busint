require 'test_helper'

class AccionsControllerTest < ActionController::TestCase

  def setup
    @acc = accions(:accion1)
    @deal = deals(:claro)
  end

  test "debe redireccionar un new no logueado" do
    get :new
    assert_not flash.empty?
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar un create no logueado" do
    assert_no_difference 'Accion.count' do
      post :create, accion: @acc.dup
    end
    assert_not flash.empty?
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar un destroy no logueado" do
    assert_no_difference 'Accion.count' do
      delete :destroy, id: @acc
    end
    assert_not flash.empty?
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar un update no logueado" do
    patch :update, id: @acc, accion: { deal: @deal, medio: @acc.medio, salida: @acc.salida, causa: "", efect: @acc.efect }
    assert_not flash.empty?
    assert_redirected_to loguearse_url
  end

  test "debe redireccionar un edit no logueado" do
    get :edit, id: @acc
    assert_not flash.empty?
    assert_redirected_to loguearse_url
  end

end
