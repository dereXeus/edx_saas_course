class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
     @all_ratings = Movie.retrieve_all_ratings
     if params[:ratings] == nil
	if session[:ratings] == nil
	   @checked_ratings = @all_ratings
	   session[:ratings] = @checked_ratings
	else
	   redirect_to movies_path(:ratings=>session[:ratings],:sortby=>session[:sortby])
	end
     elsif params[:ratings].is_a? Array
	@checked_ratings = params[:ratings]
        session[:ratings] = @checked_ratings
     else
     	@checked_ratings = params[:ratings].each_key.to_a
        session[:ratings] = @checked_ratings
     end
     @hilite = params[:sortby]
     @movies = Movie.find(:all, :order => "#{@hilite}", :conditions => {:rating=>@checked_ratings})
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
