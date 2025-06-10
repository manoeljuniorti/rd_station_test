class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  class ItemNotFound < StandardError; end
  class InvalidQuantity < StandardError; end
end
