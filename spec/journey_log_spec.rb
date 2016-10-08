require 'journey_log'

describe JourneyLog do
let(:station) {double ("station")}

  subject(:journey_log) {described_class.new}
  let(:journey) {double("journey")}

  it 'has a current journey' do
    expect(journey_log).to respond_to(:current_journey)
  end

  it 'has a history of journeys' do
    expect(journey_log).to respond_to(:history)
  end

  it 'has a start method that creates an instance of jouney' do
    journey_log.start(station)
    expect(journey_log.current_journey).to_not eq nil
  end

  it 'has an end method whih calls end_journey on the instance of journey' do
    journey_log.start(station)
    expect(journey_log.current_journey).to receive(:end_journey)
    journey_log.end(station)
  end

  it 'stores the last journey in history' do
    journey_log.start(station)
    journey_log.end(station)
    journey_log.add_journey
    expect(journey_log.history).to include journey_log.current_journey
  end

end
