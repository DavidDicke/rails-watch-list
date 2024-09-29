require 'Open-URI'

class MoviesController < ApplicationController
  def index
    @movies = Movie.search_ext(params[:query])
  end
end
