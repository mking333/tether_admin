class ParticipantPolicy
  attr_reader :user, :participant

  def initialize(current_user, participant)
    @current_user = current_user
    @participant = participant
  end

  def owned
    participant.trip.user_id == @current_user.id
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
    @current_user.admin?
  end
end
