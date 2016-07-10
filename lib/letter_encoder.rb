
class LetterEncoder
  def initialize
    create_encoder_from_file
  end

  def encode(letter)
    return @letter_to_morse[letter.downcase] if letter.length == 1
    return encode_multiple_words(letter.split(" ")) if /\s/ =~ letter
    encode_word(letter.split(//))
  end

  def encode_word(convert_word_to_morse)
    word = String.new
    convert_word_to_morse.each.with_index do |letter, index|
      word += @letter_to_morse[letter.downcase] + "000"
      word.chomp!('000') if index == convert_word_to_morse.length - 1
    end
    word
  end

  def encode_multiple_words(convert_words_to_morse)
    words = String.new
    convert_words_to_morse.each.with_index do |word, index|
      words += encode_word(word.split(//)) + "000000"
      words.chomp!('000000') if index == convert_words_to_morse.length - 1
    end
    words
  end

  def create_encoder_from_file
    encoder_from_file = File.read('../lib/morse_to_binary_translator.txt').chomp.split(';')
    @letter_to_morse = Hash.new
    encoder_from_file.each do |letter_to_morse|
      @letter_to_morse.merge!(letter_to_morse.split(',')[0] => letter_to_morse.split(',')[1])
    end
  end

end
