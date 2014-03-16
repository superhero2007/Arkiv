class Activation < Token
  set_callback :confirmed, :after, :active_member
  
  private
  def active_member
    tokenable.active
  end
end
