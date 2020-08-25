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

  def sentence_feeder
    exercice_correction if params[:commit] == COMMIT_MESSAGE

    @sentence.update_attributes VerbPractice.new(preterit: @exercice.preterit).generate
    @sentence.increment!(:session_counter)
  end

  # def fetch_preterit
  #   @preterit = @sentence.exercice
  # end

end
