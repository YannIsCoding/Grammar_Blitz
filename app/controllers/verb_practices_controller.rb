class VerbPracticesController < SentencesController
  # before_action :fetch_preterit

  def new
    @start = true
    @exercice = Exercice.find(params[:exercice_id])

    @sentence = Sentence.create!(user: current_user, exercice: @exercice)
    sentence_feeder

    render :sentence
  end

  def update
    @sentence = Sentence.find(params[:id])
    @exercice = @sentence.exercice

    sentence_feeder

    if @sentence.session_counter > SESSION_LENGTH - 1
      @redirect = sentence_result_path
    end

    respond_to do |format|
      format.js { render :update }
    end
  end

  private

  def create_trial(type)
    trial = Trial.find_by(sentence: @sentence,
                          result: 'temp')
    trial.update(result: type)
    super
  end

  def sentence_feeder
    exercice_correction if params[:commit] == COMMIT_MESSAGE
    @verb_practice = VerbPractice.new(preterit: @exercice.preterit)

    @sentence.update_attributes @verb_practice.generate
    @sentence.increment!(:session_counter)

    Trial.create!(user: current_user,
                  exercice: @exercice,
                  result: 'temp',
                  sentence: @sentence,
                  verb: @verb_practice.verb)
  end

end
