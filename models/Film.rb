require_relative("../db/sql_runner.rb")
require_relative("./Screening.rb")

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(film)
    @id = film['id'].to_i if film['id']
    @title = film['title']
    @price = film['price'].to_i()
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film_hash = SqlRunner.run(sql, values).first()
    @id = film_hash['id'].to_i()
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

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film) }
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id INNER JOIN screenings ON tickets.screening_id = screenings.id WHERE screenings.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer)}
  end

  def viewer_count()
    # You can also get this information as an SQL query using COUNT(), but this code is cleaner than putting together another long query. However, if customers() was bringing back a lot of data, it would make more sense to use a query string here instead.
    customers = customers()
    return customers.count()
  end

  def screenings()
    sql = "SELECT * FROM screenings INNER JOIN tickets ON tickets.screening_id = screenings.id WHERE screenings.film_id =$1"
    values = [@id]
    screenings_hash = SqlRunner.run(sql, values)
    return screenings_hash.map { |screening| Screening.new(screening) }
  end

  def most_popular_screening()
    sql = "SELECT screenings.*, COUNT(screening_time) FROM screenings INNER JOIN tickets ON tickets.screening_id = screenings.id GROUP BY screenings.id HAVING screenings.film_id = $1 ORDER BY count DESC LIMIT 1"
    values = [@id]
    screening_hash = SqlRunner.run(sql, values).first()
    return screening_hash['screening_time']
    # Here's a way of doing it that involves existing functions and doesn't require such a torturous SQL query.
    # screenings = screenings()
    # screening_times = screenings.map { |screening| screening.screening_time }
    # return screening_times.max_by { |time| screening_timesd.count(time) }
  end

end
