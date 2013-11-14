class RPNCalculator
  attr_accessor :arr, :value
  
  def initialize
    @arr = []
  end
  
  def push(num)
    @arr << num
  end
  
  def method_missing(m, *args, &block)
    if @arr.empty?
      raise StandardError,
        "calculator is empty"
    else
      operator = case m.to_s
        when "plus" then "+"
        when "minus" then "-"
        when "times" then "*"
        when "divide" then "/"
      end
      
      @value = @arr[-1].to_f.send(operator, @arr[-2].to_f)
      2.times {@arr.pop}
      @arr << @value
      
    end #end if
  end #end def method_missing
  
  def tokens(token)
    token.split.map {|x| x =~ /\d/ ? x.to_i : x.to_sym}  
  end
  
  def evaluate(token)
    loc = nil
    arr_token = tokens(token)
    while arr_token[1] != nil
      arr_token.detect {|x| loc= arr_token.index(x) if x.class == Symbol }
      value_return = arr_token[loc -1].to_f.send(arr_token[loc], arr_token[loc -2].to_f)
      arr_token[loc - 2] = value_return
      arr_token.delete_at(loc)
      arr_token.delete_at(loc-1)
    end #end while
    value_return
  end #end def evaluate
end

