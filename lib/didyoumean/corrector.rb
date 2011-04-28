require 'set'

module Didyoumean

  class Corrector
    def correct(word)
      candidates = known([word])
      candidates = known(edits1(word)) if candidates.empty?
      candidates = known_edits2(word) if candidates.empty?
      candidates = [word] if candidates.empty?
      candidates.max_by{|w| @nwords[w]}
    end

    def initialize(corpus_file)
      @nwords = train(words(File.read(corpus_file)))
    end
    
  private
    def words(text)
      text.downcase.scan(/[a-z]+/)
    end

    def train(features)
      model = Hash.new(1)
      features.each do |f|
        model[f] += 1
      end
      model
    end

    ALPHABET = 'abcdefghijklmnopqrstuvwxyz'

    def edits1(word)
      candidates = Set.new
       word.length.times do |i|
         x = word.dup
         x.slice!(i)
         candidates.add(x)
       end

      (word.length-1).times do |i|
        x = word.dup
        x[i], x[i+1] = x[i+1], x[i]
        candidates.add(x)
      end

      word.length.times do |i|
        ALPHABET.each_char do |a|
          x = word.dup
          x[i] = a
          candidates.add(x)
        end
      end

      (-1..word.length-1).each do |i|
        ALPHABET.each_char do |a|
          x = word.dup
          x.insert(i,a)
          candidates.add(x)
        end
      end

      candidates
    end

    def known_edits2(word)
      candidates = Set.new
      edits1(word).each do |edit|
        candidates.merge(known(edits1(edit)))
      end

      candidates
    end

    def known(words)
      Set.new(words.select{|w| @nwords.key?(w)})
    end
  end

end