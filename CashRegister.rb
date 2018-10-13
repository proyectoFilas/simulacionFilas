load 'Client.rb'


class CashRegister
    def initialize
        @available = true
      end
    
      # @client = Client.new
    
      attr_reader :client
      attr_accessor :available
    
      def serviceTime
        #de 4 a 25 minutos
        random = Random.new
        random.rand(4..25)
      end
    
      def customerArrives client, tArrive
        # puts "Atender al cliente: #{client.representation}"
        # puts "------------"
        # puts "Atendiendo"
        @client = client
        # puts "Cliente: #{@client.representation}"
        @available = false
        @timeArrive = tArrive
        # puts "arribo: #{@timeArrive}"
        @serviceTime = serviceTime
        # puts "tServicio: #{@serviceTime}"
      end
    
      def serveCustomer timeSimulacion
        unless @available
          if timeSimulacion == @timeArrive + @serviceTime
            @available = true
          end
        end
      end
end
