def caesar_cipher(s, rot)
  limits = {
    upcase: {
      upper: 90,
      lower: 65
    },
    downcase: {
      upper: 122,
      lower: 97
    }
  }

  ords = s.chars.map { |c| c.ord }
  rotated = ords.map do |c|
    if c.between?(65, 90)
      rotate_ord(c, rot, limits[:upcase])
    elsif c.between?(97, 122)
      rotate_ord(c, rot, limits[:downcase])
    else
      c
    end
  end
  rotated.map { |c| c.chr }.join
end

def rotate_ord(ord, rot, limits)
  rotated = ord + rot
  if rotated > limits[:upper]
    (rotated % limits[:upper]) + limits[:lower] - 1
  else
    rotated
  end
end

puts(caesar_cipher("What a string!", 5))
