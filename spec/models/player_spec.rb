# frozen_string_literal: true

describe Player do
  context 'Any player' do
    let(:player) { player = Player.new }

    it 'scores a gutter game' do
      player.frames = [%w[0 0]] * 10
      expect(player.score).to eq(0)
    end

    it 'scores a foul game' do
      player.frames = [%w[F F]] * 10
      expect(player.score).to eq(0)
    end

    it 'scores a game of 1s' do
      player.frames = [%w[1 1]] * 10
      expect(player.score).to eq(20)
    end

    it 'scores a game with a spare' do
      player.frames = [%w[7 3], %w[1 0]] + ([%w[0 0]] * 18)
      expect(player.score).to eq(12)
    end

    it 'scores a game with a strike' do
      player.frames = [['10'], %w[3 1]] + ([%w[0 0]] * 18)
      expect(player.score).to eq(18)
    end

    it 'scores a perfect game' do
      player.frames = ([['10']] * 9) + [%w[10 10 10]]
      expect(player.score).to eq(300)
    end

    context 'last frame' do
      it 'scores a game with a strike in last frame' do
        player.frames = [['10'], %w[7 3], %w[9 0], ['10'], %w[0 8], %w[8 2], %w[F 6], ['10'], ['10'], %w[10 8 1]]
        expect(player.score).to eq(167)
      end

      it 'scores a game with a spare in last frame' do
        player.frames = [%w[3 7], %w[6 3], ['10'], %w[8 1], ['10'], ['10'], %w[9 0], %w[7 3], %w[4 4], %w[4 6 2]]
        expect(player.score).to eq(144)
      end

      it 'scores a game with a regular last frame' do
        player.frames = [%w[3 7], %w[6 3], ['10'], %w[8 1], ['10'], ['10'], %w[9 0], %w[7 3], %w[4 4], %w[3 1]]
        expect(player.score).to eq(136)
      end

      it 'scores a regular game with a spare in last frame' do
        player.frames = [%w[8 2], %w[7 3], %w[3 4], ['10'], %w[2 8], ['10'], ['10'], %w[8 0], ['10'], %w[8 2 9]]
        expect(player.score).to eq(170)
      end
    end
  end

  context 'when load data from a valid file' do
    let(:game) { Game.new('spec/fixtures/two_players.csv') }

    context 'Jeff' do
      let(:jeff) { game.find_or_initialize_player('Jeff') }

      it 'should have a foul in first throw in seventh frame' do
        expect(jeff.frames[6].first).to eq('F')
      end

      it 'should have a strike in forth frame' do
        expect(jeff.strike?(3)).to be_truthy
      end

      it 'should have a strike in first frame' do
        expect(jeff.frames.first).to eq(['10'])
      end

      it 'should have a strike in last frame' do
        expect(jeff.frames[9].first).to eq('10')
      end

      it 'should have two bonus throws in last frame' do
        bonus_throws = jeff.frames[9] - ['10']
        expect(bonus_throws.size).to eq(2)
      end

      it 'should have a spare in second frame' do
        expect(jeff.spare?(1)).to be_truthy
      end

      it 'score for first frame (strike)' do
        expect(jeff.score_for_frame(0)).to eq(20)
      end

      it 'score for second frame (spare)' do
        expect(jeff.score_for_frame(1)).to eq(19)
      end

      it 'total score should be' do
        expect(jeff.score).to eq(167)
      end
    end
  end

  context 'when load data from a valid file with spares in last frame' do
    let(:game) { Game.new('spec/fixtures/two_players_with_spares_in_last_frame.csv') }
    
    context 'Jeff' do
      let(:jeff) { game.find_or_initialize_player('Jeff') }

      it 'should have a spare in last frame' do
        expect(jeff.frames[9].map(&:to_i).take(2).sum).to eq(10)
      end

      it 'should have one bonus throw in last frame' do
        bonus_throws = jeff.frames[9] - jeff.frames[9].take(2)
        expect(bonus_throws.size).to eq(1)
      end
    end
  end

  context 'when load data from a valid file with some erros' do
    let(:game) { Game.new('spec/fixtures/two_players_with_errors.csv') }

    context 'Jeff' do
      let(:jeff) { game.find_or_initialize_player('Jeff') }

      it 'should have 0 in first throw of second frame' do
        expect(jeff.frames[1].first).to eq(0)
      end

      it 'should have 0 in first throw of thrid frame' do
        expect(jeff.frames[2].first).to eq(0)
      end

      it 'should ignore all throws after tenth frame' do
        expect(jeff.frames.size).to eq(10)
      end
    end

    context 'John' do
      let(:john) { game.find_or_initialize_player('John') }

      it 'should ignore all throws after tenth frame' do
        expect(john.frames.size).to eq(10)
      end
    end
  end
end
