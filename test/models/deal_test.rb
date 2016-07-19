require 'test_helper'

class DealTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @producto = productos(:web)
    @deal = deals(:nextel)
  end

  test "debe ser valido" do
    assert @deal.valid?
  end
  
  test "debe ser invalido" do
    @deal.user_id = nil
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

  test "debe tener una contacto valido" do
    @deal.contacto = nil
    assert_not @deal.valid?
  end

  test "tiene que mostrar el ultimo deal modificado, primero" do
    assert_equal deals(:movistar), Deal.first
  end

  test "estado tiene que ser uno de los existentes" do
    @deal.estado = "Congelado"
    assert_not @deal.valid?
  end

  test "prueba invitar a un usuario al deal" do
    lana = users(:lana)
    assert_not @deal.cousers.include?(lana)
    @deal.invitar(lana)
    assert @deal.cousers.include?(lana)
  end

  test "prueba echar a un usuario del deal" do
    archer = users(:archer)
    @deal.invitar(archer)
    assert @deal.cousers.include?(archer)
    @deal.echar(archer)
    assert_not @deal.cousers.include?(archer)
  end

  test "prueba que participa? funcione" do
    archer = users(:archer)
    @deal.invitar(archer)
    assert @deal.cousers.include?(archer)
    assert @deal.participa?(archer)
  end    
  
end
