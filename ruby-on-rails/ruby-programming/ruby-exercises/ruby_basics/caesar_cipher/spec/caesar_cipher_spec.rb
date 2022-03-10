# frozen_string_literal: true

require './lib/caesar_cipher'

describe CaesarCipher do
  describe '#caesar_cipher' do
    it 'rotates the string by the amount specified' do
      caesar = CaesarCipher.new
      expect(caesar.caesar_cipher('What a string!', 5)).to eql('Bmfy f xywnsl!')
    end
  end

  describe '#get_limit' do
    it "returns the limits hash of the given letter's case" do
      caesar = CaesarCipher.new
      expect(caesar.get_limit('a'.ord)).to eq(
        upper: 122,
        lower: 97
      )
      expect(caesar.get_limit('A'.ord)).to eq(
        upper: 90,
        lower: 65
      )
    end
  end

  describe '#rotate_ord' do
    it 'rotates the value the appropriate amount' do
      caesar = CaesarCipher.new
      letter = 'a'.ord
      rot = 5
      limits = caesar.get_limit 'a'.ord
      expect(caesar.rotate_ord(letter, rot, limits)).to eq('f'.ord)
    end
    it 'wraps the value around if over the upper limit' do
      caesar = CaesarCipher.new
      letter = 'w'.ord
      rot = 5
      limits = caesar.get_limit 'w'.ord
      expect(caesar.rotate_ord(letter, rot, limits)).to eq('b'.ord)
    end
    it 'works the same on capital letters' do
      caesar = CaesarCipher.new
      letter = 'W'.ord
      rot = 5
      limits = caesar.get_limit 'W'.ord
      expect(caesar.rotate_ord(letter, rot, limits)).to eq('B'.ord)
    end
  end
end
