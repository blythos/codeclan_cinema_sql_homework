require_relative("../db/sql_runner.rb")

class Customer

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


end
