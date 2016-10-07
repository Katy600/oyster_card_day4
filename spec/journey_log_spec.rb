require 'journey_log'

describe JourneyLog do

subject(:journey_log) {described_class.new}

  it 'has a current journey' do
    expect(journey_log).to respond_to(:current_journey)
  end

  it 'has a history of journeys' do
    expect(journey_log).to respond_to(:history)
  end

  it 'has a start method that creates an instance of jouney'
  journey_log.start
    expect(journey_log.current_journey).to_not eq nil
end 


end
