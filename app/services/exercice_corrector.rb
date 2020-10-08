class ExerciceCorrector
  attr_reader :answers

  def initialize(trial:, params:)
    @trial = trial
    @params = params
    @answers = extract_answers
  end

  def review
    # compare the answer to the sentences using Regex
    regex = RegexMachine.new(@answers).generate
    (regex =~ @trial.value) ? :correct : :wrong
  end

  private

  def extract_answers
    # Extract the answers from the params
    @hide_index = @trial.edict.hide_index || @trial.exercice.word_indexes
    @hide_index.map do |index|
      if @params["response_#{index}"]&.strip&.empty?
        # answer is blank
        'nothing'
      else
        # filter anything that isn't allowed characters
        @params["response_#{index}"]&.gsub(/[^0-9A-Za-zäÄöÖüÜß]/, '')
      end
    end
  end
end
