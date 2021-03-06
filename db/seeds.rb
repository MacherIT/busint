# -*- coding: utf-8 -*-
estados = ["Ganado", "Perdido", "En progreso"]
productos = ["Web", "App", "Consultoría", "Neuro", "Mktg Dig"]

# Users
User.create!(name:  "Bruno Calmels",
             email: "bruno.calmels@macherit.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Juan Pablo López",
             email: "juan.lopez@macherit.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Pedro Porma",
             email: "pedro.porma@macherit.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)

#99.times do |n|
#  name  = Faker::Name.name
#  email = "example-#{n+1}@railstutorial.org"
#  password = "password"
#  User.create!(name:  name,
#               email: email,
#               password:              password,
#               password_confirmation: password,
#               activated: true,
#               activated_at: Time.zone.now)
#end

# Productos
productos.each do |p|
  Producto.create!(nombre: p)
end

# Solo para development
if ::Rails.env == 'development'

  # Empresas
  10.times do
    nombre_legal = Faker::Company.name
    nombre = nombre_legal.split(" ").first
    while Empresa.find_by(nombre: nombre) do
      nombre_legal = Faker::Company.name
      nombre = nombre_legal.split(" ").first
    end
    tel = Faker::PhoneNumber.cell_phone
    email = "info@#{nombre_legal.parameterize("")}.com"
    ciudad = rand(1..5)
    dir = Faker::Address.street_address
    Empresa.create!(nombre_legal: nombre_legal, nombre: nombre, tel: tel, email: email, ciudad: ciudad, dir: dir)
  end
  
  # Contactos 
  cargos = ["Dueño", "Vendedor", "At. al Público", "Staff"]
  10.times do
    nombre = Faker::Name.first_name
    apellido = Faker::Name.last_name
    cargo = cargos.sample
    tel = Faker::PhoneNumber.cell_phone
    dir = Faker::Address.street_address
    empresa = Empresa.all.sample
    email = "#{nombre.parameterize("")}#{apellido.parameterize("")}@#{empresa.nombre.parameterize("")}.com"
    ciudad = rand(1..5)
    familia = "Casado: #{["No", "Sí"].sample}; Hijos: #{rand(0..4)}."
    bday = Faker::Date.forward(365).to_formatted_s(:d_m)
    comentarios = Faker::Lorem.sentence(2,false,6)
    contacto = Contacto.create!(nombre: nombre, apellido: apellido, cargo: cargo, tel: tel, dir: dir, email: email, ciudad: ciudad, bday: bday, empresa: empresa, familia: familia, comentarios: comentarios)
  end  
  
  # Deals
  users = User.all
  10.times do
    posesion = rand(1..2).even?
    contacto = Contacto.all.sample
    fuente = Faker::Lorem.sentence(1)
    producto = Producto.all.sample
    probabilidad = rand(0..10)*10
    user = users.sample
    deal = user.deals.create!(contacto: contacto, fuente: fuente, producto: producto, probabilidad: probabilidad)
  end
  
  # Participaciones
  10.times do
    deal = Deal.all.sample
    user = deal.user
    otro_user = User.all.sample
    while otro_user == user
      otro_user = User.all.sample
    end
    if not deal.participa?(otro_user)
      deal.invitar(User.find_by(id: otro_user.id))
    end
  end
  Deal.first.invitar(User.second) if !Deal.first.participa?(User.second)
  Deal.first.invitar(User.third)  if !Deal.first.participa?(User.third)
  Deal.second.invitar(User.first) if !Deal.second.participa?(User.first)
  Deal.third.invitar(User.first)  if !Deal.third.participa?(User.first)
  
  # Accions
  Deal.all.each do |d|
    fs = rand(60).days.ago
    a = d.accions.create!(fecha: fs,          hecha: true, user: d.user, medio: "Llamada", salida: true, resultado: "Sigue")
    a = d.accions.create!(fecha: fs + 1.days, hecha: true, user: d.user, medio: "Social Media", salida: false, resultado: "Posterga")
    a = d.accions.create!(fecha: fs + 2.days, hecha: true, user: d.user, medio: "Visita", salida: true, resultado: "Posterga")
    a = d.accions.create!(fecha: fs + 3.days, hecha: true, user: d.user, medio: "Visita", salida: true, resultado: "Sigue")
    a = d.accions.create!(fecha: fs + 4.days, hecha: true, user: d.user, medio: "Email", salida: true, resultado: "Contrata", comentario: "Contrató Pack Mi Sitio Web Full.")
  end
  
  Deal.all.each.map { |d| d.actualizar_estado }

  
  # Comentarios
  Accion.all.each do |acc|
    acc.deal.user.comentarios.create!(accion_id: acc.id, texto: "Yo soy el dueño del deal y vengo a dejar un comentario.")
    acc.deal.cousers.all.each do |cou|
      cou.comentarios.create!(accion_id: acc.id, texto: "Yo participo también y quiero preguntar algo.")
    end
  end
  
end
