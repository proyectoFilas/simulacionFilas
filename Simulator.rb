load 'InputManager.rb'
load 'UI.rb'
load 'CashRegister.rb'
load 'Client.rb'

class Simulator
  def initialize
    @inputManager = InputManager.new()
    @customersServed = Array.new
    @userInterface = UI.new
    @time = 0
  end

  def run
    inputs = @inputManager.inputs
    queueType = inputs[0]
    numCashRegisters = inputs[1]
    simulationTime = inputs[2]
    deltaTime = inputs[3]

    cashRegisters = Array.new
    for n in (1..numCashRegisters)
      cashRegisters << CashRegister.new
    end

    #Creacion de colas
    if queueType == 1
      queue = Array.new
    else
      queues = Array.new
      for n in (1..numCashRegisters)
        queues << []
      end
    end

    #Ejecución de la simulación
    while @time <= simulationTime
      @userInterface.show "tiempo: #{@time}"
      if @time % 3 == 0
        #Llegan nuevos clientes
        clients = newClients()
        #Repartir clientes en colas
        if queueType == 1
          clients.each do |client|
            queue << client
          end
        #si son varias validar las más desocupadas
        else
          clients.each do |client|
            cashRegister = cashRegisters[less(queues)]
            if cashRegister.available
              client.exitTime = @time
              @customersServed << client
              cashRegister.customerArrives(client, @time)
            else
              queues[less(queues)] << client
            end
          end
        end
      end
      #Revisar si hay cajas desocupadas
      for i in (0..numCashRegisters - 1)
        cashRegister = cashRegisters[i]
        cashRegister.serveCustomer(@time)
        if queueType == 1
          #Para fila unica
          if cashRegister.available && !queue.empty?
            queue.first.exitTime = @time
            @customersServed << queue.first
            cashRegister.customerArrives(queue.shift, @time)
          end
        else
          #Para multiples filas
          if cashRegister.available && !queues[i].empty?
            queues[i].first.exitTime = @time
            @customersServed << queues[i].first
            cashRegister.customerArrives(queues[i].shift, @time)
          end
        end
      end
      if queueType == 1
        @userInterface.printIteration cashRegisters, queue
      else
        @userInterface.printIteration cashRegisters, queues
      end
      sleep(deltaTime)
      @time += 1
    end

    averageWaitTime = calculateAverageWaitTime(@customersServed)
    @userInterface.showAverageWaitTime (averageWaitTime)

  end

  def newClients
    #Llegan entre 0-5 clientes
    random = Random.new
    numClients = random.rand(0..5)
    clients = Array.new
    for n in (1..numClients)
      clients << Client.new(@time)
    end
    clients
  end

  def less queues
    array = Array.new
    queues.each do |queue|
      array << queue.length
    end
    array.index(array.sort[0])
  end

  def calculateAverageWaitTime clients
    averageWaitTime = 0
    clients.each do |client|
      averageWaitTime += client.exitTime - client.arrivalTime
    end
    averageWaitTime.to_f/clients.length.to_f
  end

end
