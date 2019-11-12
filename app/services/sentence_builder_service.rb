class SentenceBuilderService
  PERSON = %w[first_singular second_singular third_masculin third_feminin first_plurial second_plurial third_plurial]
  GENDER = %w[masculin feminin neutral plurial]

  def initialize(exercise)
    @exercise = exercise
    @person = PERSON.sample
    @gender = GENDER.sample
    @g_case = 'accusative'
  end

  def generate
    subject = fetch_subject
    verb = fetch_verb
    article = fetch_article
    noun = fetch_noun
    english = "#{subject[:english]} #{verb[:english]} #{article[:english]} #{noun[:english]}"
    german = "#{subject[:german]} #{verb[:german]} #{article[:german]} #{noun[:german]}"
    obfus = article[:german].split(//).map! { '_ ' }.join
    obfus = "#{subject[:german]} #{verb[:german]} #{obfus} #{noun[:german]}"
    return { sentence: german, obfus: obfus, english: english, solution: article[:german] }
  end

  private

  def fetch_subject
    personal_pronoun = PersonalPronoun.find_by(person: @person)
    { german: personal_pronoun.value, english: personal_pronoun.english }
  end

  def fetch_verb
    if @person[0..4] == 'third' && @person != 'third_plurial'
      @verb_instance = Verb.where(person: 'third_singular', g_case: @g_case).sample
      return { german: @verb_instance.value, english: @verb_instance.english }
    end
    @verb_instance = Verb.where(person: @person, g_case: @g_case).sample
    { german: @verb_instance.value, english: @verb_instance.english }
  end

  def fetch_article
    article = Article.find_by(gender: @gender, case: @g_case)
    { german: article.value, english: article.english }
  end

  def fetch_noun
    noun = @verb_instance.nouns.all.sample
    { german: noun.value, english: noun.english }
  end
end
