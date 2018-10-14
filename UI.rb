load 'CashRegister.rb'

class UI

  def show menssage
    puts menssage
  end

  #Recibe 2 arreglos, uno con las cajas registradoras y otro con las colas
  def printIteration cashRegisters, queues
    linea1 = ""
    linea2 = " "
    linea3 = ""
    cashRegisters.each do |cashRegister|
      linea1 += "|C| "
      if cashRegister.client != nil
        linea2 += "#{cashRegister.client.representation}   "
      else
        linea2 += "    "
      end
    end
    puts linea1
    puts linea2
    puts
    # puts queues[0].class
    # if queues[0].class == Client
    if queues[0].class != Array
      #Se agregan espacios para centrar cola en pantalla
      numEspacios = (linea1.length - 3)/2
      espacios = " " * numEspacios
      queues.each do |client|
        puts espacios + "|#{client.representation}|"
      end
    else
      # puts "holi"
      may = mayor queues
      # puts may
      for i in (0...may)
        linea = ""
        for j in (0...queues.length)
          # puts "wat?"
          # puts queues[j][i]
          # if queues[j][i].class != NilClass
          if queues[j][i]
            # puts "if"
            linea += "|#{queues[j][i].representation}| "
          else
            # puts "else"
            linea += "    "
          end
        end
        puts linea
      end
    end
    puts
  end

  def showAverageWaitTime time
    puts "El tiempo promedio de espera en la fila fue de #{time} minutos"
  end

  def mayor queues
    arr = Array.new
    queues.each do |queue|
      arr << queue.length
    end
    arr.sort[queues.length-1]
  end

end
