require_relative("../db/sql_runner.rb")

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(film)
    @id = film['id'].to_i if film['id']
    @title = film['title']
    @price = film['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    film = SqlRunner.run(sql, values).first()
    return Film.new(film)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

end
