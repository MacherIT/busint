require 'test_helper'

class DealTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @deal = Deal.new(user_id: @user.id, fuente:"Amigo", producto: "Web", probabilidad: 50, estado: "Ganado", empresa: "Movistar")
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

end
