class LetterDecoder
  def initialize
    create_decoder_from_file
  end

  def decode(morse_code_letter)
    return @morse_to_letter[morse_code_letter] unless /000/ =~ morse_code_letter
    return decode_multiple_words(morse_code_letter.split('000000')) if /000000/ =~ morse_code_letter
    decode_word(morse_code_letter.split('000'))
  end

  def decode_word(convert_morse_to_word)
    word = String.new
    convert_morse_to_word.each do |morse|
      word += @morse_to_letter[morse]
    end
    word
  end

  def decode_multiple_words(convert_morse_to_words)
    words = String.new
    convert_morse_to_words.each.with_index do |morse, index|
      words += decode_word(morse.split('000')) + " "
      words.chop! if index == convert_morse_to_words.length - 1
    end
    words
  end

  def create_decoder_from_file
    decoder_from_file = File.read('../lib/morse_to_binary_translator.txt').chomp.split(';')
    @morse_to_letter = Hash.new
    decoder_from_file.each do |morse_to_letter|
      @morse_to_letter.merge!(morse_to_letter.split(',')[1] => morse_to_letter.split(',')[0])
    end
  end
end
