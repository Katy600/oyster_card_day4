require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

    before do
      card.top_up(Oystercard::MONEY_LIMIT)
    end

  let(:station) {double :station, name: "angel", zone: 1}
  let(:station2) {double :bank, name: "bank", zone: 3}

  context 'balance' do
    it 'have balance' do
      expect(card).to respond_to :balance
    end
  end

  it 'has a journey_log' do
    expect(card).to respond_to :journey_log
  end

  context '#top up' do

    it 'limits top up value MONEY_LIMIT' do
      expect{card.top_up(1)}.to raise_error "Card limit is #{Oystercard::MONEY_LIMIT}."
    end

  end

  context 'touching in and out' do

    it 'touching in calls the start method in journey_log' do
      expect(card.journey_log).to receive(:start)
      card.touch_in(station)
    end



    it 'raises error if card below minimum balance when touching in' do
      card.top_up(-Oystercard::MONEY_LIMIT)
      expect{card.touch_in(station)}.to raise_error "Insufficient funds for journey"
    end

    it 'charges the card on touch out' do
      card.touch_in(station)
      expect{card.touch_out(station2)}.to change{card.balance}.by(-3)
    end

    it 'charges the card a penalty fare if you double touch in' do
      card.touch_in(station)
      expect{card.touch_in(station2)}.to change{card.balance}.by(-6)
    end

    it 'charges the card a penalty fare if you double touch out' do
      card.touch_out(station)
      expect{card.touch_out(station2)}.to change{card.balance}.by(-6)
    end

    it 'adds a complete journey to the journey history' do
      card.touch_in(station)
      card.touch_out(station2)
      expect(card.history).to eq [card.current_journey]
    end
  end
end
