require 'minitest/autorun'
require 'minitest/pride'
require '../lib/paramorse'
require '../lib/letter_decoder'

class TestLetterDecoder < Minitest::Test
  def setup
    @letter_decoder = ParaMorse::LetterDecoder.new
  end
  def test_letter_decoder_exists
    assert_instance_of LetterDecoder, @letter_decoder
  end
  def test_letter_decoder_can_receive_input
    assert @letter_decoder.decode('1')
  end
  def test_letter_decoder_returns_letters
    assert_equal true, @letter_decoder.decode('10111').to_i == 0
  end
  def test_decoder_returns_the_correct_letter
    assert_equal 'a', @letter_decoder.decode('10111')
    assert_equal 'q', @letter_decoder.decode('1110111010111')
  end
  def test_decoder_can_decode_two_letters
    assert_equal 'aq', @letter_decoder.decode('101110001110111010111')
  end
  def test_decoder_can_decode_two_words
    assert_equal 'hi al', @letter_decoder.decode('101010100010100000010111000101110101')
  end
  def test_decoder_can_decode_a_ridiculously_long_sentence
    assert_equal 'hello world', @letter_decoder.decode('10101010001000101110101000101110101000111011101110000001011101110001110111011100010111010001011101010001110101')
  end
end
