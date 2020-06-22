# frozen_string_literal: true

describe Game do
  context 'when load data from a valid file' do
    let(:game) { Game.new('spec/fixtures/two_players.csv') }

    it 'should load two players' do
      expect(game.players.size).to eq(2)
    end

    it 'shoud have a player called Jeff' do
      player = game.find_or_initialize_player('Jeff')
      expect(player.name).to eq('Jeff')
    end

    it 'shoud have a player called John' do
      player = game.find_or_initialize_player('John')
      expect(player.name).to eq('John')
    end
  end
end
