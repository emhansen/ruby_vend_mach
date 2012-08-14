module ChangeMaker
  def make_change(needed, bank)
    change = Hash.new(0)
    return change if needed <= 0

    currencies = bank.sort { |x,y| -1 * (x[0] <=> y[0]) }

    currencies.each do
      |currency, number|
      number_needed = ((needed / currency.value) + 0.001).to_i

      number_used = [number_needed, number].min()

      change[currency] = number_used
      bank[currency] = number - number_used
      needed -= currency*number_used

    end
    change
  end
end