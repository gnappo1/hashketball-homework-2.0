# Write your code here!
require 'pry'
def game_hash
    {
        home: {
            team_name: 'Brooklyn Nets',
            colors: ['Black', 'White'],
            players: [
                {
                    'Alan Anderson' => {
                        number: 0,
                        shoe: 16,
                        points: 22,
                        rebounds: 12,
                        assists: 12,
                        steals: 3,
                        blocks: 1,
                        slam_dunks: 1
                    }
                },
                {
                    'Reggie Evans' => {
                        number: 30,
                        shoe: 14,
                        points: 12,
                        rebounds: 12,
                        assists: 12,
                        steals: 12,
                        blocks: 12,
                        slam_dunks: 7
                    }
                },
                {
                    'Brook Lopez' => {
                        number: 11,
                        shoe: 17,
                        points: 17,
                        rebounds: 19,
                        assists: 10,
                        steals: 3,
                        blocks: 1,
                        slam_dunks: 15
                    }
                },
                {
                    'Mason Plumlee' => {
                        number: 1,
                        shoe: 19,
                        points: 26,
                        rebounds: 11,
                        assists: 6,
                        steals: 3,
                        blocks: 8,
                        slam_dunks: 5
                    }
                },
                {
                    'Jason Terry' => {
                        number: 31,
                        shoe: 15,
                        points: 19,
                        rebounds: 2,
                        assists: 2,
                        steals: 4,
                        blocks: 11,
                        slam_dunks: 1
                    }
                }
            ]
        },
        away: {
            team_name: 'Charlotte Hornets',
            colors: ['Turquoise', 'Purple'],
            players: [
                {
                    'Jeff Adrien' => {
                        number: 4,
                        shoe: 18,
                        points: 10,
                        rebounds: 1,
                        assists: 1,
                        steals: 2,
                        blocks: 7,
                        slam_dunks: 2
                    }
                },
                {
                    'Bismack Biyombo' => {
                        number: 0,
                        shoe: 16,
                        points: 12,
                        rebounds: 4,
                        assists: 7,
                        steals: 22,
                        blocks: 15,
                        slam_dunks: 10
                    }
                },
                {
                    'DeSagna Diop' => {
                        number: 2,
                        shoe: 14,
                        points: 24,
                        rebounds: 12,
                        assists: 12,
                        steals: 4,
                        blocks: 5,
                        slam_dunks: 5
                    }
                },
                {
                    'Ben Gordon' => {
                        number: 8,
                        shoe: 15,
                        points: 33,
                        rebounds: 3,
                        assists: 2,
                        steals: 1,
                        blocks: 1,
                        slam_dunks: 0
                    }
                },
                {
                    'Kemba Walker' => {
                        number: 33,
                        shoe: 15,
                        points: 6,
                        rebounds: 12,
                        assists: 12,
                        steals: 7,
                        blocks: 5,
                        slam_dunks: 12
                    }
                }
            ]
        }
    }
end


# HELPERS

    # First I build the merged hash to have all players in one place
    def merged_players
        game_hash[:home][:players].concat(game_hash[:away][:players])
    end

    def player_by_name(player_name)
        merged_players.detect{|player_hash| player_hash.keys[0] == player_name}
    end

    # Then I build a helper to find the right team
    def team_by_name(team_name)
        game_hash[:home].has_value?(team_name) ? game_hash[:home] : game_hash[:away]
    end

    # Collection by prop

    def collection_by_prop(team_hash, prop)
        team_hash[:players].collect{ |player_hash| player_hash.values[0][prop]}
    end

    # Max by stat

    def max_player_by_stat(stat_name)
        merged_players.max_by{|player_hash| player_hash.values[0][stat_name]}.keys[0]
    end

    # Max by stat

    def stats_by_max_value(stat_name)
        merged_players.max_by{|player_hash| player_hash.values[0][stat_name]}.values[0]
    end
    
# Methods Required - I will use [] notation over fetch

    def num_points_scored(player_name)
        player = player_by_name(player_name)
        player.values[0][:points]
    end

    def shoe_size(player_name)
        player = player_by_name(player_name)
        player.values[0][:shoe]
    end

    def team_colors(team_name)
        team_by_name(team_name)[:colors]
    end

    def team_names
        game_hash.collect{ |place, hash_value| hash_value[:team_name]}
    end

    def player_numbers(team_name)
        collection_by_prop(team_by_name(team_name), :number)
    end

    def player_stats(player_name)
        player = player_by_name(player_name)
        player.values[0]
    end

    def big_shoe_rebounds
        player_stats = stats_by_max_value(:shoe)
        player_stats[:rebounds]
    end

# Bonus

    def most_points_scored
        player_stats = max_player_by_stat(:points)
    end

    # For Ruby >=2.4.0 you can use sum from Enumerables, I have 2.3.3 and will use reduce
    def winning_team
        home_points = collection_by_prop(game_hash[:home], :points).reduce(0, :+)
        away_points = collection_by_prop(game_hash[:away], :points).reduce(0, :+)
        home_points > away_points ? game_hash[:home][:team_name] : game_hash[:away][:team_name]
    end

    def player_with_longest_name
        player = merged_players.max_by{|player_hash| player_hash.keys[0].size }
        player.keys[0]
    end


# Super Bonus

    def long_name_steals_a_ton?
        player_max_steals = max_player_by_stat(:steals)
        player_with_longest_name == player_max_steals
    end