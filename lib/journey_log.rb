class JourneyLog

  attr_reader :current_journey, :history
  def initialize
    @history = []
  end

  def start(station)
    @current_journey = Journey.new(station)
  end

  def end(station)
    @current_journey.end_journey(station)
  end

  def add_journey
    @history << @current_journey
  end
end
