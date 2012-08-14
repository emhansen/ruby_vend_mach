class Product
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
    
  COKE = Product.new("Coca Cola", 1.25)
  DIET_COKE = Product.new("Diet Coke", 1.25)
  SPRITE = Product.new("Sprite", 1.25)
  FANTA_ORANGE = Product.new("Orange Fanta", 1.30)
  ICE_MOUNTAIN_WATER = Product.new("Ice Mountain", 1.00);
end