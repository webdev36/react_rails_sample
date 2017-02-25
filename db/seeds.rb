# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_a = FactoryGirl.create(:user)
user_b = FactoryGirl.create(:user)
user_c = FactoryGirl.create(:user)
user_d = FactoryGirl.create(:user)

FactoryGirl.create(:event, user: user_a)
FactoryGirl.create(:event, user: user_a)
FactoryGirl.create(:event, user: user_a)
FactoryGirl.create(:event, user: user_a)
FactoryGirl.create(:event, user: user_a)
FactoryGirl.create(:event, user: user_a)
FactoryGirl.create(:event, user: user_a)

FactoryGirl.create(:event, user: user_b)
FactoryGirl.create(:event, user: user_b)
FactoryGirl.create(:event, user: user_b)
FactoryGirl.create(:event, user: user_b)
FactoryGirl.create(:event, user: user_b)
FactoryGirl.create(:event, user: user_b)
FactoryGirl.create(:event, user: user_b)

FactoryGirl.create(:event, user: user_c)
FactoryGirl.create(:event, user: user_c)
FactoryGirl.create(:event, user: user_c)
FactoryGirl.create(:event, user: user_c)
FactoryGirl.create(:event, user: user_c)
FactoryGirl.create(:event, user: user_c)
FactoryGirl.create(:event, user: user_c)

FactoryGirl.create(:event, user: user_d)
FactoryGirl.create(:event, user: user_d)
FactoryGirl.create(:event, user: user_d)
FactoryGirl.create(:event, user: user_d)
FactoryGirl.create(:event, user: user_d)
FactoryGirl.create(:event, user: user_d)
FactoryGirl.create(:event, user: user_d)
