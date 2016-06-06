require 'test_helper'

class DealTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @deal = @user.deals.build(fuente:"Amigo", producto: "Web", probabilidad: 50, estado: "Ganado", empresa: "Movistar")
  end

  test "debe ser valido" do
    assert @deal.valid?
  end
  
  test "debe ser invalido" do
    @deal.user_id = nil
    assert_not @deal.valid?
  end
  
  test "debe tener una fuente" do
    @deal.fuente = ""
    assert_not @deal.valid?
  end

  test "debe tener un producto" do
    @deal.producto = ""
    assert_not @deal.valid?
  end

  test "debe tener una probabilidad del 0 al 100" do
    @deal.probabilidad = "cero"
    assert_not @deal.valid?
    @deal.probabilidad = 110
    assert_not @deal.valid?
    @deal.probabilidad = -1
    assert_not @deal.valid?
    @deal.probabilidad = 0
    assert @deal.valid?
    @deal.probabilidad = 100
    assert @deal.valid?
  end

  test "debe tener una empresa valida" do
    @deal.empresa = ""
    assert_not @deal.valid?
  end

  test "tiene que mostrar el ultimo deal modificado, primero" do
    assert_equal deals(:movistar), Deal.first
  end

  test "producto tiene que ser uno de los existentes" do
    @deal.producto = "Manzanas"
    assert_not @deal.valid?
  end

  test "estado tiene que ser uno de los exstentes" do
    @deal.estado = "Congelado"
    assert_not @deal.valid?
  end
  
end
