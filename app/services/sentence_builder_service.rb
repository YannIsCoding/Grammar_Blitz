class SentenceBuilderService
  def initialize(exercice)
    @exercice = exercice
    @person = Verb.all.map(&:person).uniq.sample
    @gender = Article.all.map(&:gender).uniq.sample
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
    @person
    if @noun.verbs.where(person: @person).empty?
      return @noun.verbs.where(person: 'third_singular').sample
    end

    @noun.verbs.where(person: @person).sample
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
