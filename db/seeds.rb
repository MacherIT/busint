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
users = User.all
contador = 0
10.times do
  empresa = Faker::Name.name
  estado = estados.sample
  fuente = Faker::Lorem.sentence(1)
  producto = Producto.all.sample
  probabilidad = rand(0..10)*10
  user = users.sample
  deal = user.deals.create!(empresa: empresa, estado: estado, fuente: fuente, producto: producto, probabilidad: probabilidad)
end

# Participaciones
10.times do
  user = User.all.sample
  deal = user.deals.sample
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
