require('pry-byebug')
require_relative('models/Film.rb')

film1 = Film.new(
  {
    'title' => 'The Room',
    'price' => 10
  }
)
