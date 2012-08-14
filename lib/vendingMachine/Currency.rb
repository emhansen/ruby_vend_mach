class Currency
  attr_reader :value
   
  def initialize(value)
    @value = value
  end
  
  PENNY = Currency.new(0.01)
  NICKEL = Currency.new(0.05)
  DIME = Currency.new(0.10)
  QUARTER = Currency.new(0.25)
  DOLLAR_COIN = Currency.new(1.00)
  DOLLAR_BILL = Currency.new(1.00)
  FIVE_BILL = Currency.new(5.00)
  
  def +(other)
    @value + other.value
  end
  def *(other)
    @value * other
  end
  def <=>(other)
    return 0 if @value == other.value
    return 1 if @value > other.value
    return -1 
  end
end