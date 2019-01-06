class Testing
  attr_reader(:nesto, :druga)
  def self.nesto
    puts(8)
  end
  
  def druga
    self.nesto()
  end
  
end

Testing.nesto

t = Testing.new()

t.druga()