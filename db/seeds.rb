5.times do
  User.create!(username: Faker::StarWars.character,
                 email: Faker::Internet.free_email,
              password: "password"
              )
end

10.times do
  Movie.create!(title: Faker::Superhero.name,
            synopsis: Faker::Hipster.sentence,
        release_date: Faker::Date.backward(5000)
              )
end

10.times do
  Actor.create!(name: Faker::GameOfThrones.character,
                dob: Faker::Date.backward(5000),
                bio: Faker::ChuckNorris.fact
              )
end

10.times do
  Role.create!(movie_id: rand(1..10),
               actor_id: rand(1..10),
         character_name: Faker::Pokemon.name
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
