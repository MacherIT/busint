require 'test_helper'

class AutoEstadoDealsTest < ActionDispatch::IntegrationTest

  def setup
    @deal = deals(:claro)
    @deal.actualizar_estado
  end

  test "debe pasar de 'En progreso' a 'Ganado' con una contratacion" do
    assert_equal "En progreso", @deal.estado
    log_in_as @deal.user
    assert_difference 'Accion.count', 1 do
      @accion = { medio: "Llamada", resultado: "Contrata", fecha: 1.minutes.ago, salida: true, hecha: true}
      post accions_path, accion: @accion, deal_id: @deal.id, user_id: @deal.user.id
      assert_not flash[:success].empty?
      assert_not flash[:info].empty?
    end
    assert_equal "Ganado", @deal.reload.estado
  end

end
