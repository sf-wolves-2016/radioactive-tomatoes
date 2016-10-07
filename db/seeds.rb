require 'themoviedb-api'
require 'imdb'
require 'awesome_print'
require 'httparty'
Tmdb::Api.key("62a053ad52b7e6cbdd773fafae4737db")

# get the data, write it to json file
def fetch_movie_data_and_cache_in_json_files
  query = Imdb::Top250.new
  movies = query.movies.map do |m|
    HTTParty.get("http://www.omdbapi.com/?i=tt#{m.id}&plot=short&r=json")
  end
  movies.select do |m|
    return false if Movie.exists?(title: m['Title'])
    Movie.create!(title: m['Title'],
               synopsis: m['Plot'],
           release_date: m['Released'],
       movie_poster_url: m['Poster']
    )
  end
  File.open('db/data/movie_data.json', 'w') { |file| file.write(movies.to_json) }
end

def fetch_actor_info(actor)
  # default actor looks like Tom Hanks?
  img_path = "https://image.tmdb.org/t/p/w300_and_h450_bestv2/a14CNByTYALAPSGlwlmfHILpEIW.jpg"

  actor_search = Tmdb::Search.person(actor[:name])
  if id = actor_search['results'][0].try('id')
    img_file_name = Tmdb::Person.images(id)
    if real_path = img_file_name.try('profiles')[0].try('file_path')
      img_path = real_path
    end
  end

  sleep(0.26)
  actor[:headshot_url] = "https://image.tmdb.org/t/p/w300_and_h450_bestv2#{img_path}"
  actor
end

def fetch_actor_and_role_data_and_cache_in_json_files
  actors = []
  roles = []

  JSON.parse(File.read('db/data/movie_data.json')).each do |response|
    actors_list = response['Actors'].split(', ')
    actors_list.each do |a|
      actor = {name: a}
      unless Actor.exists?(actor)
        actors << fetch_actor_info(actor)
        Actor.create!(actors.last)
      end

      role = {
        actor: Actor.find_by(name: a),
        movie: Movie.find_by(title: response["Title"])
      }

      roles << {name: a, title: response["Title"]}
      Role.create!(role)
    end

  end
  File.open('db/data/actor_data.json', 'w') { |file| file.puts(actors.to_json) }
  File.open('db/data/role_data.json', 'w') { |file| file.write(roles.to_json) }
end

def fetch_data_and_cache_in_json_files
  fetch_movie_data_and_cache_in_json_files
  fetch_actor_and_role_data_and_cache_in_json_files
end

def get_movie_actor_and_role_data_from_json_files
  JSON.parse(File.read('db/data/movie_data.json')).each do |m|
    next if Movie.exists?(title: m['Title'])
    Movie.create!(title: m['Title'],
               synopsis: m['Plot'],
           release_date: m['Released'],
       movie_poster_url: m['Poster']
    )
  end

  JSON.parse(File.read('db/data/actor_data.json')).each do |a|
    next if Actor.exists?(name: a['name'])
    Actor.create!(a)
  end

  JSON.parse(File.read('db/data/role_data.json')).each do |r|
    Role.create!(actor: Actor.find_by(name: r["name"]),
                 movie: Movie.find_by(title: r["title"])
    )
  end
end

# fetch_data_and_cache_in_json_files
get_movie_actor_and_role_data_from_json_files

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
