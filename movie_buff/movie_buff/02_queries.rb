def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movie.select(:id, :title, :yr, :score).where(yr: 1980..1989).where(score: 3..5)
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  Movie.select(:yr).group(:yr).having("SUM(case when score > 8 then 1 else 0 end) = 0").pluck(:yr)
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.

  Actor.joins(:movies).where(movies: {title: title}).select(:id, :name).order("castings.ord")
end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.

  Movie.joins(:director, :actors).where("castings.ord = 1").where("actors.id = actors_movies.id")
    .select(:id, :title, "actors.name")
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.

  Actor.joins(:castings).select(:id, :name, "COUNT(DISTINCT(castings.id)) AS roles")
    .group(:id).where("castings.ord != 1").order("COUNT(DISTINCT(castings.id)) DESC")
    .limit(2)
end
