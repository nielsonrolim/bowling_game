# frozen_string_literal: true

describe 'Console Output' do
  it 'should assert result of a two players game' do
    result = `./bowling_game.rb spec/fixtures/two_players.csv`
    expected_output = File.read('spec/integration/expected/two_players.txt')

    expect(result).to eq(expected_output)
  end

  it 'should assert result of a perfect score' do
    result = `./bowling_game.rb spec/fixtures/perfect_score.csv`
    expected_output = File.read('spec/integration/expected/perfect_score.txt')

    expect(result).to eq(expected_output)
  end

  it 'should assert result of a zero score' do
    result = `./bowling_game.rb spec/fixtures/zero_score.csv`
    expected_output = File.read('spec/integration/expected/zero_score.txt')

    expect(result).to eq(expected_output)
  end
end
