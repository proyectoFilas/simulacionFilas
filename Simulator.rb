load 'InputManager.rb'
load 'UI.rb'
load 'CashRegister.rb'
load 'Client.rb'

class Simulator
  def initialize
    @inputManager = InputManager.new()
  end

  def run
  end

  def newClients
    #Llegan entre 0-5 clientes
    random = Random.new
    numClients = random.rand(0..5)
    # Array.new( numClients, Client.new(@time))
    clients = Array.new
    for n in (1..numClients)
      clients << Client.new(@time)
    end
    clients
  end

end
