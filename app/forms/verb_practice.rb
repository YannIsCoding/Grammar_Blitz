class VerbPractice
  attr_reader :trial

  def initialize(sentence:)
    @sentence = sentence
  end

  def launch
    update_sentence
  end

  def continue
    update_sentence(Trial.where(sentence: @sentence))
  end

  private

  def update_sentence(trials = [])
    @verb_builder = VerbBuilder.new(preterit: @sentence.exercice.preterit,
                                    user: @sentence.user,
                                    trials: trials)
    @sentence.update_attributes @verb_builder.generate
    @sentence.update(atomizable: @verb_builder.verb)
    @sentence.increment!(:session_counter)
    @sentence
  end
end
