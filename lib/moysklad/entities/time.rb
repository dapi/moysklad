class Moysklad::Entities::Time < Time
  def to_json(*args)
    to_s.to_json
  end

  def as_json(*args)
    to_s
  end

  def to_s
    strftime('%Y-%m-%d %H:%M:%S')
  end
end
