require 'vendingMachine/ChangeMaker'
require 'vendingMachine/Currency'
require 'vendingMachine/Product'
require 'set'

class VendingMachine
  include ChangeMaker
  def initialize()
    @valid_currency = [Currency::NICKEL, Currency::DIME, Currency::QUARTER].to_set
    @stagedMoney = Hash.new(0)
    @products = Hash.new(0)
    @bankMoney = Hash.new(0)
  end

  def stock(thing, number)
    stock_products(thing, number) if thing.is_a?(Product)
    stock_bank(thing, number) if thing.is_a?(Currency)
  end

  def insert_currency(value)
    return if !@valid_currency.include?(value)
    @stagedMoney[value]+=1
  end

  def view_balance
    total = 0
    @stagedMoney.each {|key, value|  total += key * value}
    total
  end

  def coin_return
    return_coins = @stagedMoney.clone
    @stagedMoney.clear()
    return_coins
  end

  def stock_products(product, number)
    @products[product]+=number
  end

  def product_count(product)
    @products[product]
  end

  def stock_bank(currency, number)
    return if !@valid_currency.include?(currency)
    @bankMoney[currency]+=number
  end

  def bank_currency_count(currency)
    @bankMoney[currency]
  end

  def purchase(product)
    raise 'Low Balance' if view_balance < product.price
    raise 'Out of Prodcut' if @products[product] <= 0
    @products[product]-=1
    change = make_change(view_balance-product.price,@bankMoney)
    return [product, change]
  end
end