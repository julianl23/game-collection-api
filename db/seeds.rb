# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed in this order:
# platforms -> game modes -> games
#

platforms = [{
                 name: 'Xbox One',
                 igdb_id: 49
             },
             {
                 name: "Nintendo Switch",
                 igdb_id: 130
             }]
Platform.create(platforms)


gameModes = [{

             }]
GameMode.create(gameModes)


# developer


# publisher


games = []
Game.create(games)


# multiplayerMode for games