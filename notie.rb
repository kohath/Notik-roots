#!/usr/bin/env ruby

def form_roots(num=3)
  num.times do |num|
  	proto = form_root
    puts "%d: %s > %s" % [num.next, proto, transform(proto)]
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

CONS = '(p|t|k|\?|m|n|N|j|w|r|h|b|d|g|t_|T|D|n_|d_|l)'
VOICED = '(m|n|N|j|w|r|b|d|g|D|n_|d_|l)'
VOICELESS = '(p|t|k|\?|h|t_|T)'
NON_NASAL = '(p|t|k|\?|j|w|r|h|b|d|g|t_|T|D|d_|l)'
VOW = '(a|i|u|y)'

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

def transform protoform
	newform = protoform.dup
	newform.gsub! /(.)(h|\?)#{CONS}/, '\1:\2'
	newform.gsub! /y/, 'i'
	newform.gsub! /#{NON_NASAL}$/, ':'
	newform.gsub! /h/, ''

	# First voice loss intervocalic and initial
	newform.gsub! /#{VOW}g#{VOW}/, '\1h\2'
	newform.gsub! /#{VOW}d_#{VOW}/, '\1j\2'
	newform.gsub! /#{VOW}d#{VOW}/, '\1j\2'
	newform.gsub! /#{VOW}D#{VOW}/, '\1l\2'
	newform.gsub! /#{VOW}b#{VOW}/, '\1w\2'

	newform.gsub! /^g#{VOW}/, 'h\1'
	newform.gsub! /^d_#{VOW}/, 'j\1'
	newform.gsub! /^d#{VOW}/, 'j\1'
	newform.gsub! /^D#{VOW}/, 'l\1'
	newform.gsub! /^b#{VOW}/, 'w\1'
	
	# assimilation
	newform.gsub! /p#{VOICED}/, 'b\1'
	newform.gsub! /t_#{VOICED}/, 'd_\1'
	newform.gsub! /t#{VOICED}/, 'd\1'
	newform.gsub! /T#{VOICED}/, 'D\1'
	newform.gsub! /k#{VOICED}/, 'g\1'
	newform.gsub! /b#{VOICELESS}/, 'p\1'
	newform.gsub! /d_#{VOICELESS}/, 't_\1'
	newform.gsub! /d#{VOICELESS}/, 't\1'
	newform.gsub! /D#{VOICELESS}/, 'T\1'
	newform.gsub! /g#{VOICELESS}/, 'k\1'
	
	newform.gsub! /(b|d_|d|D|g)j/, 'jj'
	newform.gsub! /(b|d_|d|D|g)w/, 'ww'
	newform.gsub! /(b|d_|d|D|g)(m|n|N|r)/, '\2'
	
	newform.gsub! /aw/, 'o:'
	newform.gsub! /aj/, 'e:'

	# Hiatus
	newform.gsub! /i:?j/, 'i:'
	newform.gsub! /u:?w/, 'u:'
	newform.gsub! /i:?i/, 'i:'
	newform.gsub! /u:?u/, 'u:'
	newform.gsub! /u(:?)a(:?)/, 'o\1\2'

	# nonsense reduction
	newform.sub! /:+/, ':'

	newform
end

class Array
  def random
    self[rand length]
  end
end

form_roots ARGV[0].to_i
