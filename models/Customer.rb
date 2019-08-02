require_relative("../db/sql_runner.rb")

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(customer)
    @id = customer['id'] if customer['id']
    @name = customer['name']
    @funds = customer['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values).first()
    @id = result['id'].to_i()
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


end
