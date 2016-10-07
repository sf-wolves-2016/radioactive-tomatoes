require 'themoviedb-api'
require 'imdb'
require 'awesome_print'
require 'httparty'
Tmdb::Api.key("62a053ad52b7e6cbdd773fafae4737db")

img_path_list = {}

query = Imdb::Top250.new
query.movies.each do |m|
  response = HTTParty.get("http://www.omdbapi.com/?i=tt#{m.id}&plot=short&r=json")
  next if Movie.exists?(title: response['Title'])
  Movie.create!(title: response['Title'],
             synopsis: response['Plot'],
         release_date: response['Released'],
     movie_poster_url: response['Poster']
  )
  actors_list = response['Actors'].split(', ')
  actors_list.each do |a|
    


actor_search = Tmdb::Search.person(a)
if actor_search['results']
  if actor_search['results'][0]
    id = actor_search['results'][0]['id']
  end
end


if id
  img_file_name = Tmdb::Person.images(id)
  sleep(0.26)
    if img_file_name['profiles'] == []
      img_path_list[a] = nil
    elsif img_file_name['profiles'][0]
      img_path_list[a] = img_file_name['profiles'][0]['file_path'] 
    end
else
  img_path_list[a] = "https://image.tmdb.org/t/p/w300_and_h450_bestv2/a14CNByTYALAPSGlwlmfHILpEIW.jpg"
end

  

headshot_url = "https://image.tmdb.org/t/p/w300_and_h450_bestv2#{img_path_list[a]}"
    Actor.create!(name: a, headshot_url: headshot_url) unless Actor.exists?(name: a)
    Role.create!(actor: Actor.find_by(name: a),
                 movie: Movie.find_by(title: response['Title'])
    )
  end
end

5.times do
  User.create!(username: Faker::StarWars.character,
                  email: Faker::Internet.free_email,
               password: "password"
  )
end

10.times do
  Review.create!( title: Faker::Book.title,
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
