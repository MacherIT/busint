require 'test_helper'

class EmpresasControllerTest < ActionController::TestCase
  
  def setup
    @movistar = empresas(:movistar)
    @michael = users(:michael)
    @archer = users(:archer)
  end

  test "no debe poder ver las empresas no logueado" do
    get :index
    assert_redirected_to loguearse_url
  end

  test "usuarios no admin no pueden borrar empresas" do
    assert_no_difference 'Empresa.count' do
      delete :destroy, id: @movistar
    end
    assert_redirected_to loguearse_url
    log_in_as(@archer) #non-admin
    assert_no_difference 'Empresa.count' do
      delete :destroy, id: @movistar
    end
    assert_redirected_to @movistar
    log_in_as(@michael) #admin
  end
    
  
end
