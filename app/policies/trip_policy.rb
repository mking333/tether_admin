class TripPolicy
  attr_reader :user, :trip

  def initialize(current_user, trip)
    @current_user = current_user
    @trip = trip
  end

  def owned
    trip.user_id == @current_user.id
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin?
  end

  def create?
    new?
  end

  def new?
    @current_user.admin?
  end

  def update?
    edit?
  end
 
  def edit?
    @current_user.admin?
  end
  
  def destroy?
    owned
  end
end
