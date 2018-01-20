module ActiveModelNaming
  include ActiveModel::Naming

  def model_name
    ActiveModel::Name.new(self)
  end

  def to_model
    self
  end

  def persisted?
    true
  end
end