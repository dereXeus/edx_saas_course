class Movie < ActiveRecord::Base
  def self.retrieve_all_ratings
	all = find(:all, :select => 'DISTINCT rating', :order=>'rating')
  	rating = []
	all.each do |movie|
	   rating << movie.rating
	end
	rating
  end
end
