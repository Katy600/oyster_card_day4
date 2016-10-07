require_relative 'station'
require_relative 'journey'
class Oystercard

  attr_reader :balance, :history, :current_journey

  MONEY_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @history = []
    @in_use = false
  end

  def top_up(money)
    fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds for journey" if @balance < MINIMUM_BALANCE
    deduct(:penalty) if @in_use == true
    @current_journey = Journey.new(station)
    @in_use = true
  end

  def touch_out(station)
    #when the user doesn't touch in then they get a penalty
    @in_use == false ? penalty_touch_out(station) : normal_touch_out(station)
    add_journey
    @in_use = false
  end

  def penalty_touch_out(station)
    @current_journey = Journey.new('none')
    @current_journey.end_journey(station)
    deduct(:penalty)
  end

  def normal_touch_out(station)
    @current_journey.end_journey(station)
    deduct(:fare)
  end

  def deduct(amount)
    @balance = @balance - @current_journey.calculate_fare(amount)
  end

private
  def add_journey
    @history << @current_journey
  end

end
