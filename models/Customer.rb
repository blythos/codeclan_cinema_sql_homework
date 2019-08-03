require_relative("../db/sql_runner.rb")
require_relative("./Film.rb")
require_relative("./Ticket.rb")

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(customer)
    @id = customer['id'].to_i() if customer['id']
    @name = customer['name']
    @funds = customer['funds'].to_i()
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer_hash = SqlRunner.run(sql, values).first()
    @id = customer_hash['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    film = SqlRunner.run(sql, values).first
    return Customer.new(film)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map { |customer| Customer.new(customer) }
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film) }
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE tickets.customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.map { |ticket| Ticket.new(ticket) }
  end

  def ticket_count()
    tickets = tickets()
    return tickets.count()
  end 

end
