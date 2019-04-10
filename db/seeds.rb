# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

return if Rails.env.test?

gilbert_scoville = User.create(first_name: 'Gilbert', last_name: 'Scoville', gender: User.genders[:male], age: 53)
marie_lesage = User.create(first_name: 'Marie', last_name: 'Lesage', gender: User.genders[:female], age: 31)
clement_lesage = User.create(first_name: 'Clément', last_name: 'Lesage', gender: User.genders[:other_gender], age: 27)
louise_cadieux = User.create(first_name: 'Louise', last_name: 'Cadieux', gender: User.genders[:female], age: 62)

Glycemia.create(user: gilbert_scoville, measurement: 1215, taken_at: DateTime.new(2019, 4, 1, 18, 35, 0))
Glycemia.create(user: gilbert_scoville, measurement: 1845, taken_at: DateTime.new(2019, 4, 2, 8, 29, 0))
Glycemia.create(user: marie_lesage, measurement: 1132, taken_at: DateTime.new(2019, 4, 1, 21, 45, 0))
Glycemia.create(user: louise_cadieux, measurement: 1027, taken_at: DateTime.new(2019, 4, 1, 17, 34, 0))
Glycemia.create(user: louise_cadieux, measurement: 978, taken_at: DateTime.new(2019, 4, 2, 11, 12, 0))
Glycemia.create(user: louise_cadieux, measurement: 1512, taken_at: DateTime.new(2019, 4, 2, 20, 14, 0))
Glycemia.create(user: louise_cadieux, measurement: 1134, taken_at: DateTime.new(2019, 4, 3, 18, 12, 0))
