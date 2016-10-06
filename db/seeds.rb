require 'imdb'
require 'awesome_print'
require 'httparty'


query = Imdb::Top250.new
query.movies.each do |m|
  response = HTTParty.get("http://www.omdbapi.com/?i=tt#{m.id}&plot=short&r=json")
    unless Movie.exists?(title: response['Title'])
      Movie.create!(title: response['Title'], synopsis: response['Plot'], release_date: response['Released'], movie_poster_url: response['Poster'], genres: response['Genre'])
    end
    actors_list = response['Actors'].split(', ')
    actors_list.each do |a|
      unless Actor.exists?(name: a)
        Actor.create!(name: a)
      end
        Role.create!(actor: Actor.find_by(name: a), movie: Movie.find_by(title: response['Title']))
    end
end

5.times do
  User.create!(username: Faker::StarWars.character,
                 email: Faker::Internet.free_email,
              password: "password"
              )
end

10.times do
  Review.create!(title: Faker::Book.title,
              content: Faker::Hipster.paragraph,
              upvotes: rand(1..9),
              downvotes: rand(1..9),
              rating: rand(1..5),
              reviewer_id: rand(1..5),
              reviewable_id: rand(1..10),
              reviewable_type: ['Actor', 'Movie'].sample
              )
end

10.times do
  Comment.create!(content: Faker::Hacker.say_something_smart,
             commenter_id: rand(1..5),
                review_id: rand(1..10)
                )
end
