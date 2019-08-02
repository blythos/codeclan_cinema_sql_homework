require('pry-byebug')
require_relative('models/Film.rb')

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

binding.pry
nil
