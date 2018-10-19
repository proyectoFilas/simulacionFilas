class Client

  attr_reader :representation
  attr_reader :arrivalTime
  attr_accessor :exitTime

  def initialize arrivalTime
    @arrivalTime = arrivalTime
    @representation = generateLetter
  end

  def generateLetter
    letter = (97 + rand(25)).chr
    while letter == 'c'
      letter = (97 + rand(25)).chr
    end
    letter
  end

end
