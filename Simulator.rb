load 'InputManager.rb'
load 'UI.rb'
load 'CashRegister.rb'
load 'Client.rb'

class Simulator
  def initialize
    @inputManager = InputManager.new()
  end

  def run
    inputs = @inputManager.inputs
    puts queueType = inputs[0]
    puts numCashRegisters = inputs[1]
    puts simulationTime = inputs[2]
    puts deltaTime = inputs[3]

    #Crear cajas
    # cashRegister = Array.new( numCashRegisters, CashRegister.new())
    cashRegisters = Array.new
    for n in (1..numCashRegisters)
      cashRegisters << CashRegister.new
    end

    #Manejo de colas
    if queueType == 1
      queue = Array.new
    else
      # queues = Array.new( numCashRegisters, [])
      queues = Array.new
      for n in (1..numCashRegisters)
        queues << []
      end
    end

    #Ejecución de la simulación
    while @time <= simulationTime
      puts "tiempo: #{@time}"
      if @time % 3 == 0
        #Llegan nuevos clientes
        clients = newClients()
        # puts "llegan #{clients.length} clientes"
        #Repartir clientes en colas
          #si es una todos para alla
          if queueType == 1
            clients.each do |client|
              queue << client
              # cola(queue)
            end
          #si son varias validar las más desocupadas
          else
            clients.each do |client|
              # queues[less(queues)] << client

              #Prueba
              cashRegister = cashRegisters[less(queues)]
              if cashRegister.available
                client.tiempoSalida = @time
                @customersServed << client
                cashRegister.customerArrives(client, @time)
              else
                queues[less(queues)] << client
              end
              #Fin Prueba

              # colas(queues)
              # puts "---"
            end
          end
      end
      #Revisar si hay cajas desocupadas
        #En esta revisada se sacarían los clientes de las cajas cuando se terminan de atender
      for i in (0..numCashRegisters - 1)
        cashRegister = cashRegisters[i]
        cashRegister.serveCustomer(@time)
        #Si hay cajas libres saca cliente de la cola

        #Pensar en si meter en funciones
        if queueType == 1
          #Para fila unica
          if cashRegister.available && !queue.empty?
            queue.first.tiempoSalida = @time
            @customersServed << queue.first
            cashRegister.customerArrives(queue.shift, @time)
          end
        else
          #Para multiples filas
          if cashRegister.available && !queues[i].empty?
            queues[i].first.tiempoSalida = @time
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
    # Array.new( numClients, Client.new(@time))
    clients = Array.new
    for n in (1..numClients)
      clients << Client.new(@time)
    end
    clients
  end

  def less queues
    # puts queues
    # puts queues.length
    array = Array.new
    queues.each do |queue|
      array << queue.length
    end
    # puts "el menor: #{array.sort[0]}"
    # puts "index del menor: #{array.index(array.sort[0])}"
    array.index(array.sort[0])
  end

end
