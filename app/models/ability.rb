class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # Usuario invitado (no autenticado)

    if user.admin?
      can :manage, :all
    else
      can :read, User  # Ejemplo de permiso para leer usuarios
      # Agrega más reglas de autorización según sea necesario
    end
  end
end
