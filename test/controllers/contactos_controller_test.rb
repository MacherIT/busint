require 'test_helper'

class ContactosControllerTest < ActionController::TestCase
  setup do
    @contacto = contactos(:miguel)
    @admin = users(:michael)
  end

  test "should get index" do
    log_in_as(@admin)
    get :index
    assert_response :success
    assert_not_nil assigns(:contactos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contacto" do
    assert_difference('Contacto.count') do
      post :create, contacto: { nombre: "Julio", apellido: "Cruz", email: "juliocruz@gmail.com" }
    end

    assert_redirected_to contacto_path(assigns(:contacto))
  end

  test "should show contacto" do
    log_in_as(@admin)
    get :show, id: @contacto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contacto
    assert_response :success
  end

  test "should update contacto" do
    patch :update, id: @contacto, contacto: { nombre: "Julio", apellido: "Cruz", email: "juliocruz@gmail.com" }
    assert_redirected_to contacto_path(assigns(:contacto))
  end

  test "should destroy contacto" do
    assert_difference('Contacto.count', -1) do
      delete :destroy, id: @contacto
    end

    assert_redirected_to contactos_path
  end
end
