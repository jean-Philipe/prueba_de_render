# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # Usuario invitado (no autenticado)

    if user.admin?
      can :manage, User  # Puede realizar cualquier acción en los usuarios
    else
      can :read, User  # Puede leer perfiles de usuarios
      # Agrega más reglas de autorización según sea necesario
    end
  end
end
