class Journey

  attr_reader :entry_station, :exit_station

  PENALTY_CHARGE = 6

  def initialize(station)
    @entry_station = station
  end

  def end_journey(station)
    @exit_station = station
  end

  def fare
    (@exit_station.zone - @entry_station.zone).abs + 1
  end

  def penalty
    PENALTY_CHARGE
  end

  def complete?
     !@exit_station.nil?
  end

  def calculate_fare
    (amount == :fare ? @current_journey.fare : @current_journey.penalty)
  end

end
