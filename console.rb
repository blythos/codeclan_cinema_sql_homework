require('pry-byebug')
require_relative('models/Film.rb')
require_relative('models/Customer.rb')

Film.delete_all()

film1 = Film.new(
  {
    'title' => 'The Room',
    'price' => 10
  }
)

film2 = Film.new(
  {
    'title' => 'Phenomena',
    'price' => 8
  }
)

film3 = Film.new(
  {
    'title' => 'Suspiria',
    'price' => 5
  }
)

film4 = Film.new(
  {
    'title' => 'Inferno',
    'price' => 12
  }
)

film1.save()
film2.save()
film3.save()
film4.save()

customer1 = Customer.new(
  {
    'name' => 'Tommy Wiseau',
    'funds' => 100
  }
)

customer2 = Customer.new(
  {
    'name' => 'Alexander Robertson',
    'funds' => 100
  }
)

customer3 = Customer.new(
  {
    'name' => 'Joe Halliwell',
    'funds' => 100
  }
)

customer4 = Customer.new(
  {
    'name' => 'Marta Tycinska',
    'funds' => 100
  }
)

customer1.save()
customer2.save()
customer3.save()
customer4.save()

# film1.title = 'The Disaster Artist'
# film1.update()

# film1.delete()

binding.pry
nil
