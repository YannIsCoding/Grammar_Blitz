class VerbPracticesController < SentencesController
  # before_action :fetch_preterit

  def new
    @start = true
    @exercice = Exercice.find(params[:exercice_id])

    @sentence = Sentence.create!(user: current_user, exercice: @exercice)
    sentence_feeder

    Trial.create!(user: current_user,
                  exercice: @exercice,
                  result: 'temp',
                  sentence: @sentence,
                  verb: @verb_practice.verb)

    render :sentence
  end

  def update
    @sentence = Sentence.find(params[:id])
    @exercice = @sentence.exercice

    sentence_feeder

    Trial.create!(user: current_user,
                  exercice: @exercice,
                  result: 'temp',
                  sentence: @sentence,
                  verb: @verb_practice.verb)

    if @sentence.session_counter > SESSION_LENGTH - 1
      @redirect = verb_result_path(@sentence)
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

  def create_trial(type)
    @trial = Trial.find_by(sentence: @sentence,
                          result: 'temp')
    @trial.update(result: type)
    super
  end

  def sentence_feeder
    exercice_correction if params[:commit] == COMMIT_MESSAGE
    p "HERE IS ANOTHER SHIT:"
    stuff = Trial.where(sentence_id: @sentence.id)
    p stuff
    @verb_practice = VerbPractice.new(preterit: @exercice.preterit,
                                      user: current_user,
                                      trials: Trial.where(sentence_id: @sentence.id))

    @sentence.update_attributes @verb_practice.generate
    @sentence.increment!(:session_counter)


  end

end
