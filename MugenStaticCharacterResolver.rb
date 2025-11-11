class MugenStaticCharacterResolver
  def initialize
    @names = {}
    @names["Kung Fu Man"] = "kfm720"
    @names["Minion"] = "kfm"
    @names["Clone"] = "kfm720"
  end

  def resolve(actor)
    return @names[actor.name]
  end
end
