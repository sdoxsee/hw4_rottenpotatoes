class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def find_movies_with_same_director
    movies = []
    if self.director != nil
      movies = Movie.find_all_by_director(self.director)
      movies.delete_if { |e| e == self }
    end
    movies
  end
end
