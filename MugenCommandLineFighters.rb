class MugenCommandLineFighters
  def initialize(character_resolver)
    @character_resolver = character_resolver
  end

  def get_fighters_arguments
    get_party_arguments + get_enemies_arguments
  end

  def get_party_arguments
    get_group_arguments($game_party.actors, 1)
  end

  def get_enemies_arguments
    get_group_arguments($game_troop.enemies, 2)
  end

  def get_group_arguments(fighters, starts_with)
    arguments = ""
    last_figter_dead = false

    fighters.each_with_index do |fighter, index|
      break if index == 2

      if fighter.hp > 0
        ai = !((starts_with == 1) && (index == 0))
        number = starts_with + (last_figter_dead ? 0 : (index * 2))
        arguments += get_fighter_arguments(number, fighter, ai)
      else
        last_figter_dead = true
      end
    end

    arguments
  end

  def get_fighter_arguments(number, fighter, ai)
    arguments = " -p#{number} #{@character_resolver.resolve(fighter)}" +
      " -p#{number}.life #{fighter.hp}" +
      " -p#{number}.power #{fighter.sp}"

    if ai
      arguments += " -p#{number}.ai #{fighter.int}"
    end

    arguments
  end
end
