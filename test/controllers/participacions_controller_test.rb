require 'test_helper'

class ParticipacionsControllerTest < ActionController::TestCase

  def setup
    @partic = participacions(:mic_en_claro)
    @partic2 = participacions(:mal_en_claro)
    @michael = users(:michael)
    @lana = users(:lana)
    @archer = users(:archer)
    @admin = users(:braulio)
    @malory = users(:malory)
  end

  test "un usuario no logueado no debe poder invitar" do
    assert_difference 'Participacion.count', 0 do
      post :create, deal_id: @partic.id, user_id: @lana.id
    end
    assert_redirected_to loguearse_url
  end

  test "un usuario no implicado no debe poder invitar" do
    log_in_as(@lana)
    assert_no_difference 'Participacion.count' do
      post :create, deal_id: @partic.deal_id, user_id: @lana.id
    end
    assert_redirected_to root_url
  end

  test "un usuario no logueado no debe poder echar" do
    assert_difference 'Participacion.count', 0 do
      delete :destroy, id: @partic
    end
    assert_redirected_to loguearse_url
  end

  test "un usuario no implicado no debe poder echar" do
    log_in_as(@lana)
    assert_no_difference 'Participacion.count' do
      delete :destroy, id: @partic
    end
    assert_redirected_to root_url
  end

  test "un usuario implicado debe poder invitar" do
    log_in_as(@archer)
    assert_difference 'Participacion.count', 1 do
      post :create, deal_id: @partic.deal_id, user_id: @lana.id
    end
    assert @partic.deal.participa?(@lana)
  end

  test "un usuario implicado debe poder echar" do
    log_in_as(@archer)
    assert_difference 'Participacion.count', -1 do
      delete :destroy, id: @partic
    end
    assert_not @partic.deal.participa?(@michael)
  end

  test "un admin debe poder invitar" do
    log_in_as(@admin)
    assert_difference 'Participacion.count', 1 do
      post :create, deal_id: @partic.deal_id, user_id: @lana.id
    end
    assert @partic.deal.participa?(@lana)
  end

  test "un admin debe poder echar" do
    log_in_as(@admin)
    assert_difference 'Participacion.count', -1 do
      delete :destroy, id: @partic
    end
    assert_not @partic.deal.participa?(@michael)
  end

  test "un usuario no admin no debe poder echarse" do
    log_in_as(@malory)
    assert_no_difference 'Participacion.count' do
      delete :destroy, id: @partic2
    end
    assert @partic.deal.participa?(@malory)
  end
  
end
