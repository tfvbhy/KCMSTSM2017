# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
School.create!(
	:name => "Pepperdine"
)

School.create!(
	:name => "UCI"
)

School.create!(
	:name => "UCLA"
)

School.create!(
	:name => "UCR"
)

School.create!(
	:name => "UCSB"
)

School.create!(
	:name => "UCSD"
)

School.create!(
	:name => "USC"
)

School.create!(
	:name => "Other"
)

Team.create!(
	:name => "Admin"
)

User.create!(
	:id => 1,
	:email => "tsim90@gmail.com",
	:password => "testing123",
	:fullname => "Tim Sim",
	:year => "Senior",
	:school => "2",
	:team => "1",
	:admin => true,
	:leader => false
)
