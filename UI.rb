load 'CashRegister.rb'

class UI

  def show menssage
    puts menssage
  end

  #Recibe 2 arreglos, uno con las cajas registradoras y otro con las colas
  def printIteration cashRegisters, queues
    line1 = ""
    line2 = " "
    cashRegisters.each do |cashRegister|
      line1 += "|C| "
      if cashRegister.client != nil
        line2 += "#{cashRegister.client.representation}   "
      else
        line2 += "    "
      end
    end
    puts line1
    puts line2
    puts
    if queues[0].class != Array
      #Se agregan espacios para centrar cola en pantalla
      numSpaces = (line1.length - 3)/2
      spaces = " " * numSpaces
      queues.each do |client|
        puts spaces + "|#{client.representation}|"
      end
    else
      length = higher queues
      for i in (0...length)
        line = ""
        for j in (0...queues.length)
          if queues[j][i]
            line += "|#{queues[j][i].representation}| "
          else
            line += "    "
          end
        end
        puts line
      end
    end
    puts
  end

  def showAverageWaitTime time
    puts "El tiempo promedio de espera en la fila fue de #{time} minutos"
  end

  def higher queues
    arr = Array.new
    queues.each do |queue|
      arr << queue.length
    end
    arr.sort[queues.length-1]
  end

end
