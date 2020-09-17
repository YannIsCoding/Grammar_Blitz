class VerbPracticesController < SentencesController
  # before_action :fetch_preterit

  def new
    @start = true
    @exercice = Exercice.find(params[:exercice_id])
    @sentence = Sentence.create(user: @user, exercice: @exercice)

    # @sentence = Sentence.create!(user: current_user, exercice: @exercice)
    # sentence_feeder

    # Trial.create!(user: current_user,
    #               exercice: @exercice,
    #               result: :running,
    #               sentence: @sentence,
    #               verb: @verb_builder.verb)
    @sentence = VerbPractice.new(sentence: @sentence).launch
    render :sentence
  end

  def update
    @sentence = Sentence.find(params[:id])
    @exercice = @sentence.exercice

    result = ExerciceCorrector.review
    @sentence = VerbPractice.new(sentence: @sentence).continue(result)

    sentence_feeder

    if @sentence.session_counter > SESSION_LENGTH - 1
      @redirect = verb_result_path(@sentence)
    else
      Trial.create!(user: current_user,
                    exercice: @exercice,
                    result: :running,
                    sentence: @sentence,
                    verb: @verb_builder.verb)
    end

    respond_to do |format|
      format.js { render :update }
    end
  end

  def result
    BucketFiller.new(Trial.where(sentence: @sentence)).go
    @try_again_link = exercice_verb_practice_path(@exercice)
  end

  private

  def fetch_trial(type)
    @trial = Trial.find_by(sentence: @sentence,
                           result: :running)
    @trial.update(result: type)
    super
  end

  def sentence_feeder
    # unless first time exercice correction
    exercice_correction if params[:commit] == COMMIT_MESSAGE
    @verb_builder = VerbBuilder.new(preterit: @exercice.preterit,
                                      user: current_user,
                                      trials: Trial.where(sentence: @sentence))

    @sentence.update_attributes @verb_builder.generate
    @sentence.increment!(:session_counter)
  end
end
