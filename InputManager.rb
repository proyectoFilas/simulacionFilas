load 'UI.rb'

class InputManager

  def initialize
    @userInterface = UI.new()
  end

  def inputs
    input = Array.new()
    @userInterface.show("Digite:\n 1 Para sistema de única fila\n 2 Para sistema de múltiples filas")
    input << gets.chomp.to_i

    @userInterface.show("Ingrese el número de cajas activas")
    input << gets.chomp.to_i

    @userInterface.show("Ingrese el tiempo de la simulación en minutos")
    input << gets.chomp.to_i

    @userInterface.show("Ingrese el delta de tiempo")
    input << gets.chomp.to_i
  end

end
