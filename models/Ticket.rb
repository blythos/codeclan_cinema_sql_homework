require_relative("../db/sql_runner.rb")

class Ticket

  def initialize(ticket)
    @id = ticket['id'].to_i if ticket['id']
    @customer_id = ticket['customer_id'].to_i
    @film_id = ticket['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket_hash = SqlRunner.run(sql, values).first
    @id = ticket_hash['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    ticket_hash = SqlRunner.run(sql, values).first
    return Ticket.new(ticket_hash)
  end

end
