class SentenceBuilderService
  PERSON = %w[first_singular second_singular third_masculin third_feminin first_plurial second_plurial third_plurial]
  GENDER = Article.all.map { |a| a.gender }.uniq
  def initialize(exercise)
    @exercise = exercise
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
    if @noun.verbs.where(person: @person, g_case: @g_case).empty?
      return @noun.verbs.where(person: 'third_singular', g_case: @g_case).sample
    end

    @noun.verbs.where(person: @person, g_case: @g_case).sample
  end

  def fetch_article
    Article.find_by(gender: @gender, g_case: @g_case)
  end

  def fetch_noun
    Noun.where(gender: @gender).sample
  end

  def fetch_preposition
    Preposition.where(g_case: 'accusative').sample
  end

  def s_v_do
    english = "#{@subject.english} #{@verb.english} #{@article.english} #{@noun.english}"
    german = "#{@subject.value} #{@verb.value} #{@article.value} #{@noun.value}"
    obfus = "#{@subject.value} #{@verb.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end

  def s_v_prep_do
    english = "#{@subject.english} #{@verb.english} #{@preposition.english} #{@article.english} #{@noun.english}"
    german = "#{@subject.value} #{@verb.value} #{@preposition.value} #{@article.value} #{@noun.value}"
    obfus = "#{@subject.value} #{@verb.value} #{@preposition.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end
end
