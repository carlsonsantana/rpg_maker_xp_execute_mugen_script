module MugenFight
  extend self

  def start_fight
    character_resolver = MugenStaticCharacterResolver.new
    stage_resolver = MugenStaticStageResolver.new
    executor = MugenExecutor.new(character_resolver, stage_resolver)

    battle_information = executor.execute_mugen

    result_processor = MugenResultProcessor.new(battle_information)
    result_processor.process
  end
end
