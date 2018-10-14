class Client

  attr_reader :representation
  attr_reader :tiempoLlegada
  attr_accessor :tiempoSalida

  def initialize tLlegada
    @tiempoLlegada = tLlegada
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
