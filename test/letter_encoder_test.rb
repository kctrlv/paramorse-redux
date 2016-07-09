require 'minitest/autorun'
require 'minitest/pride'
require '../lib/paramorse'
require '../lib/letter_encoder'

class TestLetterEncoder < Minitest::Test
  def setup
    @letter_encoder = ParaMorse::LetterEncoder.new
  end
  def test_letter_encoder_exists
    assert_instance_of LetterEncoder, @letter_encoder
  end
  def test_letter_encoder_can_take_a_letter
    @letter_encoder.encode('a')
  end
  def test_letter_encoder_returns_morse
    assert_equal '10111', @letter_encoder.encode('a')
  end
  def test_letter_encoder_can_encode_a_different_letter
    assert_equal '1110101', @letter_encoder.encode('d')
  end
  def test_encoder_returns_value_for_a_letter_of_any_case
    assert_equal '1110101', @letter_encoder.encode('d')
    assert_equal '1110101', @letter_encoder.encode('D')
  end
  def test_encoder_can_take_more_than_one_letter
    assert_equal '111010100011101110111000111011101', @letter_encoder.encode('dog')
  end
  def test_encoder_can_decipher_a_word_regardless_of_letter_case
    assert_equal '111010100011101110111000111011101', @letter_encoder.encode('DOg')
    assert_equal '1011101110001110111011100010111010001110101', @letter_encoder.encode('WorD')
  end
end
