class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true

  def self.search_ext(query)
    if query
      if self.where('title LIKE ?', "%#{query}%").empty?
        self.api_query(query)
        self.where('title LIKE ?', "%#{query}%")
      else
        self.where('title LIKE ?', "%#{query}%")
      end
    else
      self.all
    end
  end

  def self.api_query(query)
    # Get search word
    # build url
    url = "https://tmdb.lewagon.com/search/movie?query=#{query}."
    # request api
    api_answer = URI.open(url).read
    # parse data
    json = JSON.parse(api_answer)
    # build and return model
    json['results'].each do |result|
      movie_result = Movie.new(
        title: result['title'], overview: result['overview'], rating: result['vote_average'],
        poster_url: "https://image.tmdb.org/t/p/w400/#{result['poster_path']}"
      )
      movie_result.save
    end
  end
end
