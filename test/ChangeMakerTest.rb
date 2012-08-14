require 'test/unit'
require 'vendingMachine/ChangeMaker'
require 'vendingMachine/Currency'

class ChangeMakerTest < Test::Unit::TestCase
  include ChangeMaker
  def test_zero
    bank = Hash.new(0)
    bank[Currency::QUARTER] = 1

    change = make_change(0.00, bank)
    assert_equal(0,change.size())

    assert_equal(0,change[Currency::QUARTER])
    assert_equal(1,bank[Currency::QUARTER])
  end

  def test_exact
    bank = Hash.new(0)
    bank[Currency::QUARTER] = 1

    change = make_change(0.25, bank)
    assert_equal(1,change.size())

    assert_equal(1,change[Currency::QUARTER])
    assert_equal(0,bank[Currency::QUARTER])
  end

  def test_large_bank
    bank = Hash.new(0)
    bank[Currency::QUARTER] = 2

    change = make_change(0.25, bank)
    assert_equal(1,change.size())

    assert_equal(1,change[Currency::QUARTER])
    assert_equal(1,bank[Currency::QUARTER])
  end

  def test_small_currency
    bank = Hash.new(0)
    bank[Currency::NICKEL] = 6

    change = make_change(0.25, bank)
    assert_equal(1,change.size())

    assert_equal(5,change[Currency::NICKEL])
    assert_equal(1,bank[Currency::NICKEL])
  end

  def test_mixed_currency
    bank = Hash.new(0)
    bank[Currency::NICKEL] = 3
    bank[Currency::DIME] = 1

    change = make_change(0.25, bank)
    assert_equal(2,change.size())

    assert_equal(3,change[Currency::NICKEL])
    assert_equal(1,change[Currency::DIME])
    assert_equal(0,bank[Currency::NICKEL])
    assert_equal(0,bank[Currency::DIME])
  end

  def test_mixed_currency_2
    bank = Hash.new(0)
    bank[Currency::NICKEL] = 3
    bank[Currency::DIME] = 2

    change = make_change(0.25, bank)
    assert_equal(2,change.size())

    assert_equal(1,change[Currency::NICKEL])
    assert_equal(2,change[Currency::DIME])
    assert_equal(2,bank[Currency::NICKEL])
    assert_equal(0,bank[Currency::DIME])
  end

  def test_small_bank
    #TODO throw exception in the future
    bank = Hash.new(0)
    bank[Currency::NICKEL] = 3
    bank[Currency::DIME] = 2

    change = make_change(0.40, bank)
    assert_equal(2,change.size())

    assert_equal(3,change[Currency::NICKEL])
    assert_equal(2,change[Currency::DIME])
    assert_equal(0,bank[Currency::NICKEL])
    assert_equal(0,bank[Currency::DIME])
  end

  def test155
    bank = Hash.new(0)
    bank[Currency::NICKEL] = 100
    bank[Currency::DIME] = 100
    bank[Currency::QUARTER] = 100

    change = make_change(1.55, bank)
    assert_equal(6,change[Currency::QUARTER])
    assert_equal(0,change[Currency::DIME])
    assert_equal(1,change[Currency::NICKEL])

  end

end