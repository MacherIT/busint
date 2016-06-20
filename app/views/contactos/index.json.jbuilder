json.array!(@contactos) do |contacto|
  json.extract! contacto, :id
  json.url contacto_url(contacto, format: :json)
end
