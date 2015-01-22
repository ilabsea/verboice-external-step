# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Operator.destroy_all

Operator.create! name: 'mobitel', code: 1
Operator.create! name: 'smart', code: 2
Operator.create! name: 'beeline', code: 3
Operator.create! name: 'metfone', code: 4
Operator.create! name: 'qb', code: 5
Operator.create! name: 'cootel', code: 6
Operator.create! name: 'other', code: 0
