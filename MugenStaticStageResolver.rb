class MugenStaticStageResolver
  def initialize
    @names = {}
    @names["background"] = "kfm"
  end

  def resolve
    return @names[$game_map.battleback_name]
  end
end
