require_relative("../db/sql_runner.rb")

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

end
