class SentenceBuilderService
  PERSON = %w[first_singular second_singular third_masculin third_feminin first_plurial second_plurial third_plurial]
  GENDER = %w[masculin feminin neutral plurial]

  def initialize(exercice)
    @exercice = exercice
    @person = PERSON.sample
    @gender = GENDER.sample
    @g_case = 'accusative'
  end

  def generate
    @subject = fetch_subject
    @article = fetch_article
    @noun = fetch_noun
    @verb = fetch_verb
    @preposition = fetch_preposition
    send(@exercice.structure.name)
  end

  private

  def fetch_subject
    PersonalPronoun.find_by(person: @person)
  end

  def fetch_verb
    return @noun.verbs.where(person: 'third_singular').sample if @noun.verbs.where(person: @person).empty?

    @noun.verbs.where(person: @person).sample
  end

  def fetch_article
    Article.where(gender: @gender, g_case: @g_case).sample
  end

  def fetch_noun
    Noun.where(gender: @gender).sample
  end

  def fetch_preposition
    Preposition.where(g_case: 'accusative').sample
  end

  def s_v_do
    english = "#{@subject.english} #{@verb.english} #{@article.english} #{@noun.english}"
    german = "#{@subject.value.capitalize} #{@verb.value} #{@article.value} #{@noun.value.capitalize}"
    obfus = "#{@subject.value.capitalize} #{@verb.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value.capitalize}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end

  def s_v_prep_do
    english = "#{@subject.english} #{@verb.english} #{@preposition.english} #{@article.english} #{@noun.english}"
    german = "#{@subject.value.capitalize} #{@verb.value} #{@preposition.value} #{@article.value} #{@noun.value.capitalize}"
    obfus = "#{@subject.value.capitalize} #{@verb.value} #{@preposition.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value.capitalize}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end

  def v_s_do
    english = "#{@person.include?('mascu' || 'femi') ? 'does' : 'do' } #{@subject.english} #{@verb.english} #{@article.english} #{@noun.english}?"
    german = "#{@verb.value} #{@subject.value} #{@article.value} #{@noun.value.capitalize}?"
    obfus = "#{@verb.value.capitalize} #{@subject.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value.capitalize}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end
end
