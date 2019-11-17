class SentenceBuilderService
  attr_reader :g_case, :person, :genders, :gender, :verb, :subject, :article
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
    raise "No gender found" if @genders.empty?

    @genders.sample
  end

  def fetch_subject
    personal_pronoun = PersonalPronoun.find_by(person: @person)
    raise "No personal pronoun found with person #{@person}" if personal_pronoun.nil?

    personal_pronoun
  end

  def fetch_article
    article = Article.where(gender: @gender, g_case: @g_case).sample
    raise "No Article found with gender #{@gender} and g_case #{@g_case}" if article.nil?

    article
  end

  def fetch_noun
    if @g_case == 'dative'
      noun = Noun.where(gender: @gender, kind: 'people').sample
    else
      noun = Noun.where(gender: @gender).sample
    end
    raise "No noun found with the gender #{@gender} and the g_case #{@g_case}" if noun.nil?

    noun
  end

  def fetch_verb
    if @noun.verbs.where(person: @person).empty?
      verb = @noun.verbs.where(person: 'third_singular', g_case: @g_case).sample
    else
      verb = @noun.verbs.where(person: @person, g_case: @g_case).sample
    end
    raise "No verb found with the noun #{@noun}, person #{@person} and g_case #{@g_case}" if verb.nil?

    verb
  end

  def fetch_preposition
    preposition = Preposition.where(g_case: 'accusative').sample
    raise "No preoposition found with g_case #{g_case}" if preposition.nil?

    preposition
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
