require '../lib/letter_decoder'
require '../lib/letter_encoder'
require '../lib/morse_queue'

class StreamDecoder
  def initialize
    @input = String.new
    @queue = MorseQueue.new
    @decode = LetterDecoder.new
    @encode = LetterEncoder.new
  end

  def receive(input)
    @queue.push(input)
  end

  def decode
    until @queue.count == 0
      @input += @queue.pop
    end
    @decode.decode(@input)
  end

  def encode
    until @queue.count == 0
      @input += @queue.pop
    end
    @encode.encode(@input)
  end

end
