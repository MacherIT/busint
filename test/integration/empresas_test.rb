require 'test_helper'

class EmpresasTest < ActionDispatch::IntegrationTest

  def setup
    @movistar = empresas(:movistar)
    @michael = users(:michael)
    @archer = users(:archer)
  end

  test "los admins pueden borrar empresas" do
    log_in_as(@michael) #admin
    assert_difference 'Empresa.count', -1 do
      delete empresa_path(@movistar)
    end
    assert_redirected_to empresas_path
  end
end
