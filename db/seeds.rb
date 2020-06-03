# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
EnergyProvider.delete_all

p "All EnergyProvider deleted"

EnergyProvider.create(name: "Grünwelt", url: "https://www.gruenwelt.de/")


EnergyProvider.create(name: "Innogy", url: "https://www.innogydirekt.de/produkte/productfinder")

EnergyProvider.create(name: "Vattenfall", url: "https://www.vattenfall.de/")

EnergyProvider.create(name: "RWE", url: "https://www.group.rwe/")

EnergyProvider.create(name: "Eon", url: "https://www.eon.de/de/pk.html")

p "Energy providers created"
