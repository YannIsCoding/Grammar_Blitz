class SentenceBuilderService
  attr_reader :g_case, :person, :genders, :gender, :verb, :subject, :article, :noun, :preposition
  def initialize(exercice)
    @exercice = exercice
    @g_case = @exercice.structure.name == 's_v_do_dative' ? 'dative' : 'accusative' #NEED TO BE REPLACE BY AN OPTION INSIDE EXERCICE TABLE SO USER CAN SELECT DIFFERENT FORM OF EXERCISES
    @person = PersonalPronoun.all.map(&:person).uniq.sample
    @person_verb = fetch_person_verb
    @gender = fetch_gender
    @definite_article = true if @exercice.structure.name.include?('prep')
  end

  def generate
    @preposition = fetch_preposition if @exercice.structure.name == 's_v_prep_do'
    @subject = fetch_subject
    @article = fetch_article
    @noun = fetch_noun
    @verb = fetch_verb
    send(@exercice.structure.name)
  end

  private

  def fetch_preposition
    preposition = Preposition.where(g_case: @g_case).sample
    raise "No preposition found with g_case #{g_case}" if preposition.nil?

    preposition
  end

  def fetch_person_verb
    if @person == 'third_masculin' || @person == 'third_feminin'
      person_verb = 'third_singular'
    else
      person_verb = @person
    end
    raise "No person found" if person_verb.nil?

    person_verb
  end

  def fetch_gender
    genders = Article.all.map(&:gender).uniq
    return genders.reject { |gender| gender == 'neutral' }.sample if @g_case == 'dative'
    raise "No gender found" if genders.empty?

    genders.sample
  end

  def fetch_subject
    personal_pronoun = PersonalPronoun.find_by(person: @person)
    raise "No personal pronoun found with person #{@person}" if personal_pronoun.nil?

    personal_pronoun
  end

  def fetch_article
    if @definite_article
      article = Article.where(gender: @gender, g_case: @g_case, definite: @definite_article).sample
    else
      article = Article.where(gender: @gender, g_case: @g_case).sample
    end
    raise "No Article found with gender #{@gender}, g_case #{@g_case} and definite #{@definite_article}" if article.nil?

    article
  end

  def fetch_noun
    if @g_case == 'dative'
      noun = Noun.where(gender: @gender, kind: 'people').sample
    elsif @preposition
      noun = Noun.where(gender: @gender, kind: @preposition.kind_nouns.sample).sample
    else
      noun = Noun.where(gender: @gender, %w[object vehicule animal food building people place].sample).sample
    end
    raise "No noun found with the gender #{@gender}" if noun.nil?

    noun
  end

  def fetch_verb
    if @preposition
      verb = Verb.where(preterit: @preposition.verbs.sample, person: @person_verb).sample
      raise "No verb found with the preposition #{@preposition.value} only accept: #{@preposition.verbs} person #{@person_verb}" if verb.nil?
    else
      verb = @noun.verbs.where(person: @person_verb, g_case: @g_case).sample
      raise "No verb found with the noun #{@noun.value}, person #{@person_verb} and g_case #{@g_case}" if verb.nil?
    end

    verb
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
    english = "#{@person == 'third_singular' ? 'Does' : 'Do' } #{@subject.english} #{@verb.english} #{@article.english} #{@noun.english}?"
    german = "#{@verb.value.capitalize} #{@subject.value} #{@article.value} #{@noun.value.capitalize}?"
    obfus = "#{@verb.value.capitalize} #{@subject.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value.capitalize}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end

  def s_v_do_dative
    s_v_do
  end

  def s_v_io_do
    english = "#{@subject.english.capitalize} #{@verb.english} #{@article.english} #{@noun.english}"
    german = "#{@subject.value.capitalize} #{@verb.value} #{@article.value} #{@noun.value.capitalize}"
    obfus = "#{@subject.value.capitalize} #{@verb.value} #{@article.value.split(//).map! { '_ ' }.join} #{@noun.value.capitalize}"
    { sentence: german, obfus: obfus, english: english, solution: @article.value }
  end
end
