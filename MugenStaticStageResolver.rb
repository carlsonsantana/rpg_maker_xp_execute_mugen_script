class MugenStaticStageResolver
  def initialize
    @names = {}
    @names["background0"] = "stage0-720"
    @names["background"] = "kfm"
  end

  def resolve
    return @names[$game_map.battleback_name]
  end
end
