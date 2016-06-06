# -*- coding: utf-8 -*-
estados = ["Ganado", "Perdido", "En espera", "Trabajo contratado"]
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

# Deals
users = User.order(:created_at).take(3)
contador = 0
10.times do
  empresa = Faker::Name.name
  estado = estados.sample
  fuente = Faker::Lorem.sentence(1)
  contador = contador % 4 + 1
  producto = Producto.find(contador)
  contador += 1
  probabilidad = rand(0..10)*10
  users.sample.deals.create!(empresa: empresa, estado: estado, fuente: fuente, producto: producto, probabilidad: probabilidad)
end

