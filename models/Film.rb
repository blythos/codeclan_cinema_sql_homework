class Film

  def initialize(film)
    @id = film['id'].to_i if film['id']
    @title = film['title']
    @price = film['price'].to_i
  end

end
