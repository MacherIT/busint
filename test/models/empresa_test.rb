require 'test_helper'

class EmpresaTest < ActiveSupport::TestCase

  def setup
    @empresa = empresas(:movistar)
  end

  test "debe tener un nombre" do
    @empresa.nombre = ""
    assert_not @empresa.valid?
  end

  test "debe tener una ciudad de las 5 disponibles" do
    @empresa.ciudad = 6
    assert_not @empresa.valid?
    @empresa.ciudad = 0
    assert_not @empresa.valid?
    @empresa.ciudad = ""
    assert @empresa.valid?
  end
  

end
