class RegexMachine
  def initialize(answers)
    @answers = answers
  end

  def generate
    regex = '(^|.*[ ])'
    @answers.each do |answer|
      regex << answer + '[ ].*'
    end
    regex[-5..-1] = '($|[ ]|.*)'
    Regexp.new(regex)
  end
end
