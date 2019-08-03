require('pry-byebug')
require_relative('models/Film.rb')
require_relative('models/Customer.rb')
require_relative('models/Ticket.rb')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

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
    'funds' => 325
  }
)

customer3 = Customer.new(
  {
    'name' => 'Joe Halliwell',
    'funds' => 1000
  }
)

customer4 = Customer.new(
  {
    'name' => 'Marta Tycinska',
    'funds' => 750
  }
)

customer1.save()
customer2.save()
customer3.save()
customer4.save()

ticket1 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id' => film1.id
  }
)

ticket2 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id' => film2.id
  }
)

ticket3 = Ticket.new(
  {
    'customer_id' => customer2.id,
    'film_id' => film1.id
  }
)

ticket4 = Ticket.new(
  {
    'customer_id' => customer3.id,
    'film_id' => film3.id
  }
)

ticket5 = Ticket.new(
  {
    'customer_id' => customer3.id,
    'film_id' => film3.id
  }
)

ticket6 = Ticket.new(
  {
    'customer_id' => customer4.id,
    'film_id' => film1.id
  }
)

ticket7 = Ticket.new(
  {
    'customer_id' => customer4.id,
    'film_id' => film2.id
  }
)

ticket8 = Ticket.new(
  {
    'customer_id' => customer4.id,
    'film_id' => film3.id
  }
)

ticket9 = Ticket.new(
  {
    'customer_id' => customer4.id,
    'film_id' => film4.id
  }
)

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()
ticket7.save()
ticket8.save()
ticket9.save()

# film1.title = 'The Disaster Artist'
# film1.update()

# film1.delete()

# customer1.funds = 10
# customer1.update()

# ticket1.customer_id = customer4.id
# ticket1.update()

binding.pry
nil
