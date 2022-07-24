class MugenResultProcessor
  def initialize(battle_information)
    @battle_information = battle_information
  end

  def process
    if @battle_information[:winner] == :player
      process_victory
    else
      lose_game
    end
  end

  def process_victory
    kill_enemy_team

    change_party_status
  end

  def kill_enemy_team
    kill_team($game_troop.enemies)
  end

  def change_party_status
    last_figter_dead = false

    $game_party.actors.each_with_index do |fighter, index|
      break if index == 2

      if fighter.hp > 0
        party_index = index - (last_figter_dead ? 1 : 0)

        fighter_life = @battle_information[:party_life][party_index]
        fighter_mp = @battle_information[:party_mp][party_index]

        fighter.hp = fighter_life
        fighter.sp = fighter_mp
      else
        last_figter_dead = true
      end
    end
  end

  def lose_game
    kill_team($game_party.actors)
  end

  def kill_team(team)
    for character in team
      character.hp = 0
    end
  end
end
