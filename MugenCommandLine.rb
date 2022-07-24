class MugenCommandLine
  def initialize(character_resolver, stage_resolver)
    @command_line_fighters = MugenCommandLineFighters.new(character_resolver)
    @stage_resolver = stage_resolver
  end

  def generate
    "start /b /wait cmd /c " +
      MugenConfiguration::BATCH_FILE +
      @command_line_fighters.get_fighters_arguments +
      " -s #{@stage_resolver.resolve}" +
      " -log #{MugenConfiguration::RESULT_FILE}" +
      " -rounds 1"
  end
end
