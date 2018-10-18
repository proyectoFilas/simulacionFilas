load 'Client.rb'

class CashRegister

  def initialize
    @available = true
  end

  attr_reader :client
  attr_accessor :available

  def serviceTime
    random = Random.new
    random.rand(4..25)
  end

  def customerArrives client, tArrive
    @client = client
    @available = false
    @arrivalTime = tArrive
    @serviceTime = serviceTime
  end

  def serveCustomer timeSimulacion
    unless @available
      if timeSimulacion == @arrivalTime + @serviceTime
        @available = true
      end
    end
  end

end
