class MugenExecutor
  def initialize(character_resolver, stage_resolver)
    @command_line = MugenCommandLine.new(character_resolver, stage_resolver)
    @closed = false
  end

  def execute_mugen
    @closed = false

    delete_result_file
    thread = Thread.new {
      system(@command_line.generate)

      sleep(MugenConfiguration::TIMEOUT_RESULT)

      @closed = true
    }
    wait_until_has_a_winner

    thread.exit()

    get_battle_information
  end

  def wait_until_has_a_winner
    wait_until_result_file_exists

    loop do
      sleep(1)
      Graphics.update
      File.open(MugenConfiguration::RESULT_FILE_RELATIVE_PATH, "r") do |iniFile|
        iniFile.each_line do |line|
          return nil if line.include?("winningteam") or @closed
        end
      end
    end
  end

  def wait_until_result_file_exists
    loop do
      sleep(1)
      Graphics.update
      break if File.file?(MugenConfiguration::RESULT_FILE_RELATIVE_PATH) or @closed
    end
  end

  def get_battle_information
    return get_lose_battle_information if @closed

    winner = nil
    timeleft = nil
    party_life = []
    party_mp = []

    File.open(MugenConfiguration::RESULT_FILE_RELATIVE_PATH, "r") do |iniFile|
      iniFile.each_line do |line|
        winner_match = line.match(/winningteam = (\d)/)
        if winner_match
          winner = winner_match[1] == "1" ? :player : :enemy
        end

        timeleft_match = line.match(/timeleft = (\d+)/)
        if timeleft_match
          timeleft = timeleft_match[1].to_i
        end

        player_life_match = line.match(/p1\.life = (\d+)/)
        if player_life_match
          party_life[0] = player_life_match[1].to_i
        end

        partner_life_match = line.match(/p3\.life = (\d+)/)
        if partner_life_match
          party_life[1] = partner_life_match[1].to_i
        end

        player_mp_match = line.match(/p1\.power = (\d+)/)
        if player_mp_match
          party_mp[0] = player_mp_match[1].to_i
        end

        partner_mp_match = line.match(/p3\.power = (\d+)/)
        if partner_mp_match
          party_mp[1] = partner_mp_match[1].to_i
        end
      end
    end

    delete_result_file

    result = {}
    result[:winner] = winner
    result[:timeleft] = timeleft
    result[:party_life] = party_life
    result[:party_mp] = party_mp

    result
  end

  def get_lose_battle_information
    result = {}
    result[:winner] = :enemy
    result[:timeleft] = 0
    result[:party_life] = [0, 0]
    result[:party_mp] = [0, 0]

    result
  end

  def delete_result_file
    if File.file?(MugenConfiguration::RESULT_FILE_RELATIVE_PATH)
      File.delete(MugenConfiguration::RESULT_FILE_RELATIVE_PATH)
    end
  end
end
