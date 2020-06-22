# frozen_string_literal: true

class Player
  attr_accessor :name
  attr_accessor :frames
  attr_reader :first_in_frame

  def initialize(name = nil)
    @name = name
    @frames = []
    @first_in_frame = 0
  end

  def score
    sum = 0

    frames.each_with_index do |_f, i|
      sum += score_for_frame(i)
    end

    sum
  end

  def score_for_frame(frame_index)
    sum = frames[frame_index].map(&:to_i).sum
    if strike?(frame_index)
      sum += bonus_for_strike(frame_index)
    elsif spare?(frame_index)
      sum += bonus_for_spare(frame_index)
    end
    sum
  end

  def closed_last_frame?
    last_frame = frames.last

    frames.size == 10 &&
    ((last_frame.first == '10' && last_frame.size == 3) ||
      (last_frame.first.to_i < 10 && last_frame.size == 2 && last_frame[0].to_i + last_frame[1].to_i < 10) ||
      (last_frame.first.to_i < 10 && last_frame.size == 3))
  end

  def spare?(frame_index)
    frame = frames[frame_index]
    frame.present? && (frame[0].to_i + frame[1].to_i == 10)
  end

  def strike?(frame_index)
    frame = frames[frame_index]
    frame.present? && frame.size == 1 && frame.first.to_i == 10
  end

  private

  def bonus_for_spare(frame_index)
    next_frame = frames[frame_index + 1]
    return 0 if next_frame.nil? || frame_index == 9

    next_frame.first.to_i
  end

  def bonus_for_strike(frame_index)
    next_frame = frames[frame_index + 1]
    if strike?(frame_index + 1)
      next_frame.first.to_i + frames[frame_index + 2].first.to_i
    else
      next_frame[0].to_i + next_frame[1].to_i
    end
  end

end
