require "test/unit"
require "didyoumean"

#
# There are an awful lot of cases... which I can't be bothered enumerating
# Perhaps I should move the error models out an test them separately
#
class DidyoumeanTest < Test::Unit::TestCase

  def setup
    @corrector = Didyoumean::Corrector.new("bisley bisley bosley")
  end

  def test_should_return_word_if_spelled_correctly
    assert_equal "bosley", @corrector.correct("bosley")
  end

  def test_should_return_word_with_one_extra_char
    assert_equal "bosley", @corrector.correct("bossley")
  end

  def test_should_return_most_likely_word_with_two_extra_chars
    assert_equal "bisley", @corrector.correct("boisleey")
  end

  def test_should_return_word_with_one_transpose
    assert_equal "bosley", @corrector.correct("obsley")
  end

  def test_should_return_word_with_two_transposes
    assert_equal "bosley", @corrector.correct("osbley")
  end

  def test_should_return_most_likely_word_with_one_char_incorrect
    assert_equal "bisley", @corrector.correct("basley")
  end

  def test_should_return_most_likely_word_with_two_chars_incorrect
    assert_equal "bisley", @corrector.correct("casley")
  end

  def test_should_return_most_likely_word_with_one_char_missing
    assert_equal "bisley", @corrector.correct("bsley")
  end

  def test_should_return_most_likely_word_with_two_chars_missing
    assert_equal "bisley", @corrector.correct("bsly")
  end

  def test_should_return_original_word_if_we_cany_correct
    assert_equal "aaaa", @corrector.correct("aaaa")
  end
end