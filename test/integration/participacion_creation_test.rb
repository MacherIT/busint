require 'test_helper'

class ParticipacionCreationTest < ActionDispatch::IntegrationTest

  def setup
    @partic = participacions(:mic_en_claro)
    @partic2 = participacions(:mal_en_claro)
    @michael = users(:michael)
    @lana = users(:lana)
    @archer = users(:archer)
    @admin = users(:braulio)
    @malory = users(:malory)
  end

  test "va al edit de un deal como admin y chequea los botones de participantes" do
    log_in_as(@admin)
    get edit_deal_path(@partic.deal)
    assert_template 'deals/edit'
    assert_select "form#new_participacion" do
      assert_select "input", { id: "user_id", value:"#{@lana.id}" }
      assert_select "input", { value: "{@lana.name}", class: "no_participa" }
    end
    assert_select "form#new_participacion" do
      assert_select "input", { id: "user_id", value:"#{@michael.id}" }
      assert_select "input", { value: "{@michael.name}", class: "participa" }
    end
    assert_difference 'Participacion.count', -1 do
      delete participacion_path(@partic)
    end
    assert_redirected_to edit_deal_path(@partic.deal)
    follow_redirect!
    assert_template 'deals/edit'
    assert_select "form#new_participacion" do
      assert_select "input", { id: "user_id", value:"#{@michael.id}" }
      assert_select "input", { value: "{@michael.name}", class: "no_participa" }
    end
  end

  test "va al edit de un deal como participante y chequea los botones de participantes" do
    log_in_as(@michael)
    get edit_deal_path(@partic.deal)
    assert_template 'deals/edit'
    assert_select "form#new_participacion" do
      assert_select "input", { id: "user_id", value:"#{@lana.id}" }
      assert_select "input", { value: "{@lana.name}", class: "no_participa" }
    end
    assert_select "form#new_participacion" do
      assert_select "input", { id: "user_id", value:"#{@malory.id}" }
      assert_select "input", { value: "{@malory.name}", class: "participa" }
    end
    assert_difference 'Participacion.count', -1 do
      delete participacion_path(@partic2)
    end
    assert_redirected_to edit_deal_path(@partic2.deal)
    follow_redirect!
    assert_template 'deals/edit'
    assert_select "form#new_participacion" do
      assert_select "input", { id: "user_id", value:"#{@malory.id}" }
      assert_select "input", { value: "{@malory.name}", class: "no_participa" }
    end
    # Chequea que no se puede borrar a si mismo
    assert_difference 'Participacion.count', 0 do
      delete participacion_path(@partic)
    end
    assert_redirected_to edit_deal_path(@partic.deal)
    follow_redirect!
    assert_not flash.empty?
    assert_template 'deals/edit'
    assert_select "form#new_participacion" do
      assert_select "input", { id: "user_id", value:"#{@michael.id}" }
      assert_select "input", { value: "{@michael.name}", class: "participa" }
    end    
  end

end
