class VerbPractice
  def initialize(sentence:)
    @sentence = sentence
  end

  def launch
    update_sentence
    # generate_trial

    @sentence
  end

  def continue(result)
    # @trial = Trial.find_by(sentence: @sentence,
    #                        result: :running)
    # @trial.update(result: (result ? :correct : :wrong))
    # generate_trial #unless @sentence.session_finish?
    Trial.create!(user: @sentence.user,
                  exercice: @sentence.exercice,
                  result: (result ? :correct : :wrong),
                  sentence: @sentence,
                  verb: @verb_builder.verb)

    update_sentence(Trial.where(sentence: @sentence))
    @sentence
  end

  private

  def update_sentence(trials = [])
    @verb_builder = VerbBuilder.new(preterit: @sentence.exercice.preterit,
                                    user: @sentence.user,
                                    trials: trials)
    @sentence.update_attributes @verb_builder.generate
    @sentence.increment!(:session_counter)
  end

  def generate_trial
    Trial.create!(user: @sentence.user,
                  exercice: @sentence.exercice,
                  result: :running,
                  sentence: @sentence,
                  verb: @verb_builder.verb)
  end
end
