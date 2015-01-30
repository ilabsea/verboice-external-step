# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


operators = [ {name: 'mobitel', code: 1},
              {name: 'smart', code: 2},
              {name: 'beeline', code: 3},
              {name: 'metfone', code: 4},
              {name: 'qb', code: 5},
              {name: 'cootel', code: 6},
              {name: 'other', code: 0}]

operators.each do |attrs|
  operator = Operator.where(name: attrs[:name]).first_or_initialize
  operator.update_attributes(attrs)
end


instances=[ { name: "http://192.168.1.141:3000/", url: "http://192.168.1.141:3000/", end_point: "http://192.168.1.141:3000//api2", default: true }]
instances.each do |attrs|
  instance = Instance.where(name: attrs[:name]).first_or_initialize
  instance.update_attributes(attrs)
end