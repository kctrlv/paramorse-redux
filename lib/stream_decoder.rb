require '../lib/letter_decoder'
# require '../lib/letter_encoder'
require '../lib/morse_queue'

class StreamDecoder
  def initialize
    @queue = MorseQueue.new
    @decode = LetterDecoder.new
    @detect_end_of_letter = String.new
    @input = String.new
    @complete_letter = Array.new
  end

  def receive(input)
    @queue.push(input)
    detect_end_of_letter(input) if input == '0'
    detect_end_of_text(input) if input == '1' && end_of_letter?
    clear_end_of_letter if input == '1'
    @queue
  end

  def detect_end_of_letter(input)
    @detect_end_of_letter += input
    end_of_letter(false) if @detect_end_of_letter =~ /00/
    if @detect_end_of_letter =~ /000/
      @complete_letter << @queue.pop until @queue.count == 0
      end_of_letter(true)
    end
    @detect_end_of_letter
  end

  def clear_end_of_letter
    @detect_end_of_letter = ""
  end

  def decode
    @decode.decode(send_complete_letter)
  end

  def send_complete_letter
    @complete_letter.join.gsub(/000/,"")
  end

  def end_of_letter?(value = true)
    value
  end

  # def encode
  #   until @queue.count == 0
  #     @input += @queue.pop
  #   end
  #   @encode.encode(@input)
  # end

end
