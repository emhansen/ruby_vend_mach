require 'test/unit'
require 'VendingMachine'
require 'vendingMachine/Currency'
require 'vendingMachine/Product'
class VendingMachineTest < Test::Unit::TestCase
  
  def test_coin_return 
    vms = VendingMachine.new()
    vms.insert_currency(Currency::QUARTER)
    assert_equal( 0.25, vms.view_balance(), 'should be 0.25')
    
    coins = vms.coin_return()
    assert_equal( 1, coins[Currency::QUARTER], 'should have 1 quarter')
    assert_equal( 1, coins.size(), 'size should be 1')
    assert_equal( 0, vms.view_balance(), 'balance should be 0 after coin return')
  end
  
  def test_insert
    vms = VendingMachine.new()
    vms.insert_currency(Currency::DIME)
    assert_equal(0.10, vms.view_balance)
    vms.insert_currency(Currency::NICKEL)
    assert_in_delta(0.15, vms.view_balance, 0.001)
    
    vms.insert_currency(Currency::PENNY)
    assert_in_delta(0.15, vms.view_balance, 0.001)
    
  end
  
  def test_stock_products
    vms = VendingMachine.new()
    vms.stock_products(Product::SPRITE,10)
    assert_equal(10,vms.product_count(Product::SPRITE))
  end
  
  def test_stock_bank
    vms = VendingMachine.new()
    vms.stock(Currency::QUARTER, 100)
    vms.stock(Currency::NICKEL, 50)
    vms.stock(Currency::DIME, 20)
    vms.stock(Currency::PENNY, 1)
    
    assert_equal(100, vms.bank_currency_count(Currency::QUARTER))
    assert_equal(50, vms.bank_currency_count(Currency::NICKEL))
    assert_equal(20, vms.bank_currency_count(Currency::DIME))
    assert_equal(0, vms.bank_currency_count(Currency::PENNY))
  end
  
  def test_stock
    vms = VendingMachine.new()
    vms.stock(Product::SPRITE,10)
    assert_equal(10,vms.product_count(Product::SPRITE))
  end
  
  def test_stock_and_purchase
    vms = VendingMachine.new()
    vms.stock(Product::SPRITE,10)
    assert_equal(10,vms.product_count(Product::SPRITE))
    vms.stock(Currency::QUARTER,100)
    vms.stock(Currency::DIME,100)
    vms.stock(Currency::NICKEL,100)
        
    6.times do
      vms.insert_currency(Currency::QUARTER)
    end
    
    result = vms.purchase(Product::SPRITE)
    assert_equal(Product::SPRITE,result[0])
    assert_equal(1, result[1][Currency::QUARTER])
    
    assert_equal(vms.product_count(Product::SPRITE),9)
  end
  
  def test_stock_and_purchase_return
    vms = VendingMachine.new()
    vms.stock(Product::FANTA_ORANGE,10)
    vms.stock(Product::SPRITE,10)
    assert_equal(10,vms.product_count(Product::FANTA_ORANGE))
    assert_equal(10,vms.product_count(Product::SPRITE))
    vms.stock(Currency::QUARTER,100)
    vms.stock(Currency::DIME,100)
    vms.stock(Currency::NICKEL,100)
        
    6.times do
      vms.insert_currency(Currency::QUARTER)
    end
    
    result = vms.purchase(Product::FANTA_ORANGE)
    assert_equal(Product::FANTA_ORANGE,result[0])
    assert_equal(2, result[1][Currency::DIME])
    
    assert_equal(vms.product_count(Product::FANTA_ORANGE),9)
    assert_equal(vms.product_count(Product::SPRITE),10)
    
  end
  
end