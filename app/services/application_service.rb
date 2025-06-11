class ApplicationService
  def self.call(**kwargs, &block)
    new(**kwargs, &block).call
  end

  class InvalidQuantity < StandardError; end
  class ItemNotFound < StandardError; end
end
