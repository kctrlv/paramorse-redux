require '../lib/letter_decoder'
require '../lib/morse_queue'
require 'pry'

class StreamDecoder
  attr_reader :letter_string

  def initialize
    @queue = MorseQueue.new
    @letter_string = String.new
    @decode = LetterDecoder.new
    @detect_end_of_letter = String.new
    @input = String.new
    @complete_letter = String.new
  end

  def receive(input)
    @queue.push(input)
    detect_end_of_letter(input) if input == '0'
    clear_end_of_letter if input == '1'
  end

  def detect_end_of_letter(input)
    @detect_end_of_letter += input
    end_of_letter if @detect_end_of_letter =~ /000/ && !end_of_word?
    end_of_word if end_of_word?
  end

  def end_of_letter
  @complete_letter += @queue.pop until @queue.count == 0
  decode
  clear_complete_letter
  end

  def end_of_word

  end

  def end_of_word?
    return true if @detect_end_of_letter =~ /000000/
    false
  end

  def clear_end_of_letter
    @detect_end_of_letter = ""
  end

  def clear_complete_letter
    @complete_letter = ""
  end

  def decode
    @letter_string += @decode.decode(@complete_letter)
  end
end
