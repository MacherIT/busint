require 'test_helper'

class EmpresaTest < ActiveSupport::TestCase

  def setup
    @empresa = empresas(:movistar)
  end

  test "debe tener un nombre" do
    @empresa.nombre = ""
    assert_not @empresa.valid?
  end

end
