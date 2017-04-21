class Moysklad::Entities::Time < Time
  def to_json(*args)
    strftime('%Y-%m-%d %H:%M:%S').to_json
  end
end
