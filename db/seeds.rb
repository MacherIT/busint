# -*- coding: utf-8 -*-
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

users = User.order(:created_at).take(3)
estados = ["Ganado", "Perdido", "En espera de respuesta"]
productos = ["Web", "App", "Consultoría", "Neuromarketing"]
10.times do
  empresa = Faker::Name.name
  estado = estados.sample
  fuente = Faker::Lorem.sentence(1)
  producto = productos.sample
  users.sample.deals.create!(empresa: empresa, estado: estado, fuente: fuente, producto: producto)
end
