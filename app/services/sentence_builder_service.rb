class SentenceBuilderService
  def initialize(exercice)
    @exercice = exercice
    @g_case = @exercice.structure.name == 's_v_do_dative' ? 'dative' : 'accusative' #NEED TO BE REPLACE BY AN OPTION INSIDE EXERCICE TABLE SO USER CAN SELECT DIFFERENT FORM OF EXERCISES
    @person = PersonalPronoun.all.map(&:person).uniq.sample
    @genders = Article.all.map(&:gender).uniq
    @gender = fetch_gender
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

  def fetch_gender
    return @genders.reject { |gender| gender == 'neutral' }.sample if @g_case == 'dative'

    @genders.sample
  end

  def fetch_subject
    PersonalPronoun.find_by(person: @person)
  end

  def fetch_verb
    if @noun.verbs.where(person: @person).empty?
      return @noun.verbs.where(person: 'third_singular', g_case: @g_case).sample
    end

    @noun.verbs.where(person: @person, g_case: @g_case).sample
  end

  def fetch_article
    Article.where(gender: @gender, g_case: @g_case).sample
  end

  def fetch_noun
    return Noun.where(gender: @gender, kind: 'people').sample if @g_case == 'dative'

    Noun.where(gender: @gender).sample
  end

  def fetch_preposition
    Preposition.where(g_case: 'accusative').sample
  end

  def s_v_do
    english = "#{@subject.english.capitalize} #{@verb.english} #{@article.english} #{@noun.english}"
    german = "#{@subject.value.capitalize} #{@verb.value} #{@article.value} #{@noun.value.capitalize}"
    obfus = "#{@subject.value.capitalize} #{@verb.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value.capitalize}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end

  def s_v_prep_do
    english = "#{@subject.english.capitalize} #{@verb.english} #{@preposition.english} #{@article.english} #{@noun.english}"
    german = "#{@subject.value.capitalize} #{@verb.value} #{@preposition.value} #{@article.value} #{@noun.value.capitalize}"
    obfus = "#{@subject.value.capitalize} #{@verb.value} #{@preposition.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value.capitalize}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end

  def v_s_do
    english = "#{@person.include?('masculin' || 'feminin') ? 'Does' : 'Do' } #{@subject.english} #{@verb.english} #{@article.english} #{@noun.english}?"
    german = "#{@verb.value} #{@subject.value} #{@article.value} #{@noun.value.capitalize}?"
    obfus = "#{@verb.value.capitalize} #{@subject.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value.capitalize}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end

  def s_v_do_dative
    s_v_do
  end
end
