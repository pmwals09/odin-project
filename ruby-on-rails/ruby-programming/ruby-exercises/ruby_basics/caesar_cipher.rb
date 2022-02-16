# frozen_string_literal: true

LIMITS = {
  upcase: {
    upper: 90,
    lower: 65
  },
  downcase: {
    upper: 122,
    lower: 97
  }
}.freeze

def caesar_cipher(str, rot)
  ords = str.chars.map(&:ord)
  rotated = ords.map do |c|
    char_limit = get_limit(c)
    if c.between?(65, 90) || c.between?(97, 122)
      rotate_ord(c, rot, char_limit)
    else
      c
    end
  end
  rotated.map(&:chr).join
end

def get_limit(char)
  char.between?(65, 90) ? LIMITS[:upcase] : LIMITS[:downcase]
end

def rotate_ord(ord, rot, limits)
  rotated = ord + rot
  if rotated > limits[:upper]
    (rotated % limits[:upper]) + limits[:lower] - 1
  else
    rotated
  end
end

puts(caesar_cipher('What a string!', 5))
