require_relative("../db/sql_runner.rb")
require_relative("./Ticket.rb")

class Screening

  attr_accessor :screening_time, :available_tickets, :film_id
  attr_reader :id

  def initialize(screening)
    @id = screening['id'].to_i if screening['id']
    @screening_time = screening['screening_time']
    @available_tickets = screening['available_tickets'].to_i
    @film_id = screening['film_id']
  end

  def save()
    sql = "INSERT INTO screenings (screening_time, available_tickets, film_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@screening_time, @available_tickets, @film_id]
    screening_hash = SqlRunner.run(sql, values).first()
    @id = screening_hash['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE screenings SET (screening_time, available_tickets, film_id) = ($1, $2, $3) WHERE id = $4"
    values = [@screening_time, @available_tickets, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    return screenings.map { |screening| Screening.new(screening) }
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    screening_hash = SqlRunner.run(sql, values).first
    return Screening.new(screening_hash)
  end

  def tickets()
    sql = "SELECT tickets.* FROM tickets WHERE screening_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.map { |ticket| Ticket.new(ticket) }
  end

  def sell_tickets()
    # This decreases the amount of available tickets available for a screening.
    tickets = tickets()
    @available_tickets = @available_tickets - tickets.count()
    update()
  end

end
