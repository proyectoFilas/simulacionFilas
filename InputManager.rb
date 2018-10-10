load 'UI.rb'

# attr_accesor :inputs
class InputManager
  def initialize
    @userInterface = UI.new()
  end

  def inputs
    input = Array.new()
    @userInterface.show("Digite:\n 1 Para sistema de única fila\n 2 Para sistema de múltiples filas")
    input << gets.chomp
    # Validar input que sea 1 o 2

    if input[0].to_i == 2
      @userInterface.show("Ingrese el número de cajas activas")
      input << gets.chomp
      # Validar que sea un número entero mayor a 1
    else
      input << 0   
    end

    @userInterface.show("Ingrese el tiempo de la simulación en minutos")
    input << gets.chomp
    # Validar que sea un valor entero mayor a 0

    @userInterface.show("Ingrese el delta de tiempo")
    input << gets.chomp
    # Validar que sea un valor entero mayor a 0
  end

end
