# frozen_string_literal: true

describe Player do
  let(:player) { player = Player.new }

  it 'scores a gutter game' do
    player.frames = [['0', '0']] * 10
    expect(player.score).to eq(0)
  end

  it 'scores a foul game' do
    player.frames = [['F', 'F']] * 10
    expect(player.score).to eq(0)
  end

  it 'scores a game of 1s' do
    player.frames = [['1', '1']] * 10
    expect(player.score).to eq(20)
  end

  it 'scores a game with a spare' do
    player.frames = [['7', '3'], ['1', '0']] + ([['0', '0']] * 18)
    expect(player.score).to eq(12)
  end

  it 'scores a game with a strike' do
    player.frames = [['10'], ['3', '1']] + ([['0', '0']] * 18)
    expect(player.score).to eq(18)
  end

  it 'scores a perfect game' do
    player.frames = ([['10']] * 9) + [['10', '10', '10']]
    expect(player.score).to eq(300)
  end

  context 'last frame' do
    it 'scores a game with a strike in last frame' do
      player.frames = [['10'], ['7', '3'], ['9', '0'], ['10'], ['0', '8'], ['8', '2'], ['F', '6'], ['10'], ['10'], ['10', '8', '1']]
      expect(player.score).to eq(167)
    end
  
    it 'scores a game with a spare in last frame' do
      player.frames = [['3', '7'], ['6', '3'], ['10'], ['8', '1'], ['10'], ['10'], ['9', '0'], ['7', '3'], ['4', '4'], ['4', '6', '2']]
      expect(player.score).to eq(144)
    end
  
    it 'scores a game with a regular last frame' do
      player.frames = [['3', '7'], [6, '3'], ['10'], ['8', '1'], ['10'], ['10'], ['9', '0'], ['7', '3'], ['4', '4'], ['3', '1']]
      expect(player.score).to eq(136)
    end    
  end

end
