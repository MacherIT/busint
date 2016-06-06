require 'test_helper'

class ProductoTest < ActiveSupport::TestCase

  def setup 
    @prod = Producto.new(nombre: "Cosas")
  end

  test "tiene que tener un nombre" do
    assert @prod.valid?
    @prod.nombre = ""
    assert_not @prod.valid?
  end
  
  test "tiene que tener un nombre que no exista" do
    @prod.nombre = "Web"
    if (@prod.valid? && @prod.save)
      prod2 = Producto.new(nombre: "web")
      assert_not prod2.valid?
    else
      assert_not @prod.valid?
    end
  end
end
