#!/usr/bin/env ruby

def form_roots(num=3)
  num.times do |num|
  	proto = form_root
    puts "%d: %s" % [num.next, proto, transform(proto)]
  end
end

def form_root
  root_shape, root_shape_2, root_shape_3 = rand(100), rand(100), rand(100)
  root = ""
  
  root << consonant if root_shape < 25
  root << consonant
  root << vowel
  root << consonant if root_shape.between?(15,55)
  root << consonant
  root << vowel
  root << consonant if root_shape_2 < 40
  root << consonant
  root << vowel
  root << consonant if root_shape_2 < 75
  root
end

CONS = "(p|t|k|?|m|n|N|j|w|r|h|b|d|g|t_|T|D|n_|d_)"
VOW = "(a|i|u|y)"

def consonant
	consonants = {
		4 => %w{p t k ?},
		3 => %w{m n N j w r h},
		2 => %w{b d g t_},
		1 => %w{T D n_ d_}
	}

	chosen = rand 11
	case 
	when chosen < 2 then consonants[1].random
	when chosen < 4 then consonants[2].random
	when chosen < 7 then consonants[3].random
	else consonants[4].random
	end
end

def vowel
	%w{a i u y}.random
end

class Array
  def random
    self[rand length]
  end
end

form_roots ARGV[0].to_i
