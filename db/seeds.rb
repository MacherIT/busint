# -*- coding: utf-8 -*-
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(5)
estados = ["Ganado", "Perdido", "En espera de respuesta"]
productos = ["Web", "App", "Consultoría", "Neuromarketing"]
50.times do
  empresa = Faker::Name.name
  estado = estados.sample
  fuente = Faker::Lorem.sentence(1)
  producto = productos.sample
  users.sample.deals.create!(empresa: empresa, estado: estado, fuente: fuente, producto: producto)
end
