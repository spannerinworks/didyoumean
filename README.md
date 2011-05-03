Did You Mean
============

An implementation of Peter Norvig's the toy spellchecker in ruby.

See: http://norvig.com/spell-correct.html

Usage
=====

> require 'didyoumean'
> corrector = Didyoumean::Corrector.new(File.read('big.txt'))
> corrector.correct('abstrac')
=> "abstract"