require 'awesome_print'
require 'themoviedb-api'
Tmdb::Api.key("62a053ad52b7e6cbdd773fafae4737db")
actor_search = Tmdb::Search.person('Martin Sheen')
id = actor_search['results'][0]['id']
img_file_name = Tmdb::Person.images(id)
img_path = img_file_name['profiles'][0]['file_path']
p img_path
headshot_url = https://image.tmdb.org/t/p/w300_and_h450_bestv2/'#{img_path}'
p headshot_url



# str="\"1,2,3,4\""
# str.gsub!('"', '')
# puts str
# 1,2,3,4

