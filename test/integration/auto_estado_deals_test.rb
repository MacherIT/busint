require 'test_helper'

class AutoEstadoDealsTest < ActionDispatch::IntegrationTest

  def setup
    @deal = deals(:claro)
  end

  test "debe pasar de 'En progreso' a 'Ganado' con una contratacion" do
    assert_equal @deal.estado, "En progreso"
    post new_accion_path, 


end
