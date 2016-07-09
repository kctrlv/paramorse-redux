
class LetterEncoder
  def initialize
    create_encoder_from_file
  end

  def encode(letter)
    return @letter_to_morse[letter.downcase] if letter.length == 1
    convert_word_to_morse(letter.split(//))
  end

  def convert_word_to_morse(word)
    morse_word = String.new
    word.each.with_index do |letter, index|
      unless index == word.length - 1
        morse_word += @letter_to_morse[letter.downcase] + "000"
      else
        morse_word += @letter_to_morse[letter.downcase]
      end
    end
    morse_word
  end

  def create_encoder_from_file
    encoder_from_file = File.read('../lib/morse_to_binary_translator.txt').chomp.split(';')
    @letter_to_morse = Hash.new
    encoder_from_file.each do |letter_to_morse|
      @letter_to_morse.merge!(letter_to_morse.split(',')[0] => letter_to_morse.split(',')[1])
    end
  end

end
