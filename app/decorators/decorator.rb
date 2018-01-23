require "delegate"

class Decorator < SimpleDelegator
  
  def to_model
    __getobj__
  end

  def class
    __getobj__.class
  end

  def self.decorate(object)
    return nil if object.nil?
    decorate_collection_if_present(object)
  end

  private

    def self.decorate_collection_if_present(object)
      object.is_a?(Array) ? object.map { |obj| new(obj) } : new(object)
    end

end