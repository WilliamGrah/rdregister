# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

states = ["SP", "SC", "RJ", "RS", "MG", "PR", "PE", "PA", "RN", "AM"]
names = ["João", "Rosane", "Pedro", "Clark", "Jonas", "Clara", "Karina", "Ana", "Rodolfo", "Miguel", "Paulo", "Luis"]
jobs = ["programador", "design", "pedreiro", "contador", "advogado", "redator", "jornalista", "cozinheiro", "veterinario"]

for i in 0..20
	state = states[rand(0..(states.count-1))]
	name = names[rand(0..(names.count-1))]
	email = "#{name}#{i}@gmail.com"
	age = rand(10..99)
	job = jobs[rand(0..(jobs.count-1))]

	puts Contact.create({name: name, email: email, state: state, age: age, job:job}).inspect
end