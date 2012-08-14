require 'UsDenomination'
class Main
  puts( 'hello world!')
  #puts( UsDenominations.PENNY )
  
  c1 = UsDenomination.new("1",10)
  puts( c1 + c2 )
  
  def blah
    print 'hello world'
    
  end
  
  Main.new.blah
end