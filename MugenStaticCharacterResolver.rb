class MugenStaticCharacterResolver
  def initialize
    @names = {}
    @names["Kung Fu Man"] = "kfm"
    @names["Minion"] = "kfm"
    @names["Clone"] = "kfm"
  end

  def resolve(actor)
    return @names[actor.name]
  end
end
