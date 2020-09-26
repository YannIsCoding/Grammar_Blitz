class VerbPracticesController < SentencesController
  def new
    @start = true
    @exercice = Exercice.find(params[:exercice_id])
    @sentence = Sentence.create(user: current_user, exercice: @exercice)
    @sentence = VerbPractice.new(sentence: @sentence).launch
    render :sentence
  end

  def update
    @sentence = Sentence.find(params[:id])
    @exercice = @sentence.exercice

    correction = ExerciceCorrector.new(sentence: @sentence, params: params)
    result = correction.review
    @responses = correction.answers
    @trial = Trial.create!(user: @sentence.user,
                           exercice: @sentence.exercice,
                           result: result,
                           sentence: @sentence,
                           verb: @sentence.atomizable)

    unless @sentence.session_finish?
      @verb_practice = VerbPractice.new(sentence: @sentence)
      @sentence = @verb_practice.continue
    else
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

  def fetch_trial(type)
    @trial = Trial.find_by(sentence: @sentence,
                           result: :running)
    @trial.update(result: type)
    super
  end
end
