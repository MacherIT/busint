require 'test_helper'

class AccionTest < ActiveSupport::TestCase

  def setup
    @acc = accions(:accion1)
    @acc2 = accions(:accion2)
    @acc3 = accions(:accion3)
  end

  test "debe tener deal_id" do
    @acc.deal_id = nil
    assert_not @acc.valid?
  end

  test "debe tener user_id" do
    @acc.user_id = nil
    assert_not @acc.valid?
  end


  test "debe tener efect" do
    @acc.efect = nil
    assert_not @acc.valid?
  end

  test "debe tener medio" do
    @acc.medio = ""
    assert_not @acc.valid?
  end

  test "debe tener efect valido" do
    @acc.efect = "No valido"
    assert_not @acc.valid?
  end

  test "debe tener medio valido" do
    @acc.medio = "No valido"
    assert_not @acc.valid?
  end

  test "debe mostrar la mas nueva primero" do
    assert Accion.first == @acc3
    assert Accion.second == @acc
    assert Accion.third == @acc2
  end

end
