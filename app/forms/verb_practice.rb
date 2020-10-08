class VerbPractice
  attr_reader :trial

  def initialize(trial:)
    @trial = trial
  end

  def launch
    update_sentence
  end

  def continue
    update_sentence(Trial.completed.where(sentence: @trial.sentence))
  end

  private

  def update_sentence(trials = [])
    @verb_builder = VerbBuilder.new(preterit: @trial.exercice.preterit,
                                    user: @trial.user,
                                    trials: trials)
    @trial.update_attributes @verb_builder.generate
    @trial.update(atomizable: @verb_builder.verb)
    @trial
  end
end
