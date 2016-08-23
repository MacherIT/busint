module AccionsHelper

  def icono(accion)
    resp = Hash.new
    resp[:salida] = content_tag :span, "", class: "glyphicon glyphicon-arrow-#{(accion.salida ? 'right' : 'left')}"
    resp[:hecha]  = content_tag :span, "", class: "glyphicon glyphicon-#{(accion.hecha ? 'ok' : 'remove')}"
    return resp
  end

end
