class ExerciceCorrector
  def initialize(sentence:, params:)
    @sentence = sentence
    @params = params
  end

  def review
    # compare the answer to the sentences using Regex
    regex = RegexMachine.new(extract_answers).generate
    !!(regex =~ @sentence.value)
  end

  private

  def extract_answers
    # Extract the answers from the params
    @sentence.word_indexes.map do |index|
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
