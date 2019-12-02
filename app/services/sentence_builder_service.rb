class SentenceBuilderService
  attr_reader :g_case, :person, :genders, :gender, :verb, :subject, :article, :noun, :preposition
  def initialize(exercice)
    @exercice = exercice
    @vowel = ('aeiou')
    @g_case = @exercice.structure.name == 's_v_do_dative' ? 'dative' : 'accusative'
    @person = PersonalPronoun.all.map(&:person).uniq.sample
    @person_verb = fetch_person_verb
    @gender = fetch_gender
    @definite_article = true if @exercice.structure.name.include?('prep')
  end

  def generate
    @preposition = fetch_preposition if @exercice.structure.name == 's_v_prep_do'
    @subject = fetch_subject
    if @exercice.structure.name == 's_v_io_do'
      send(@exercice.structure.name)
    else
      if @exercice.structure.name == 's_v_do_dative'
        noun_kind = 'people'
      elsif @preposition
        noun_kind = 'idea'
      else
        noun_kind = Noun.all.map(&:kind).uniq.reject { |n| n == 'idea' }.sample
      end
      @noun = fetch_noun(noun_kind)
      @article = fetch_article(@g_case, @noun.gender)
      @verb = fetch_verb
      send(@exercice.structure.name)
    end
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

  def fetch_article(g_case, gender)
    if @definite_article
      article = Article.where(gender: gender, g_case: g_case, definite: @definite_article).sample
    else
      article = Article.where(gender: gender, g_case: g_case).sample
    end
    raise "No Article found with gender #{gender}, g_case #{g_case} and definite #{@definite_article}" if article.nil?

    article
  end

  def fetch_noun(noun_kind)
    noun = Noun.where(kind: noun_kind).sample
    raise "No noun found with the kind of noun #{noun_kind}" if noun.nil?

    noun
  end

  def fetch_verb(preterit = false)
    if preterit
      verb = Verb.where(preterit: preterit, person: @person_verb).sample
      raise "No verb found with the preterit: #{preterit} person #{@person_verb}" if verb.nil?
    elsif @preposition
      verb = Verb.where(preterit: @preposition.verbs.sample, person: @person_verb).sample
      raise "No verb found with the preposition #{@preposition.value} only accept: #{@preposition.verbs} person #{@person_verb}" if verb.nil?
    else
      verb = @noun.verbs.where(person: @person_verb, g_case: @g_case).sample
      raise "No verb found with the noun #{@noun.value}, person #{@person_verb} and g_case #{@g_case}" if verb.nil?
    end

    verb
  end

  def s_v_do
    { sentence: "#{@subject.value.capitalize} #{@verb.value} #{@article.value} #{@noun.value.capitalize}",
      obfus: "#{@subject.value.capitalize} #{@verb.value} #{@article.value.split(//).map! { '_' }.join} #{@noun.value.capitalize}",
      english: "#{@subject.english.capitalize} #{@verb.english} #{definite_article(@article)} #{@noun.english}",
      solution: [@article.value]}
  end

  def s_v_prep_do
    { sentence: "#{@subject.value.capitalize} #{@verb.value} #{@preposition.value} #{@article.value} #{@noun.value.capitalize}",
      obfus: "#{@subject.value.capitalize} #{@verb.value} #{@preposition.value} #{@article.value.split(//).map! { '_' }.join} #{@noun.value.capitalize}",
      english: "#{@subject.english.capitalize} #{@verb.english} #{@preposition.english} #{definite_article(@article)} #{@noun.english}",
      solution: [@article.value] }
  end

  def v_s_do
    { sentence: "#{@verb.value.capitalize} #{@subject.value} #{@article.value} #{@noun.value.capitalize}?",
      obfus: "#{@verb.value.capitalize} #{@subject.value} #{@article.value.split(//).map! { '_' }.join} #{@noun.value.capitalize}",
      english: "#{@person_verb == 'third_singular' ? 'Does' : 'Do' } #{@subject.english} #{@person_verb == 'third_singular' ? @verb.english[0..-2] : @verb.english} #{definite_article(@article)} #{@noun.english}?",
      solution: [@article.value] }
  end

  def s_v_do_dative
    s_v_do
  end

  def s_v_io_do
    io_noun = fetch_noun('people')
    io_article = fetch_article('dative', io_noun.gender)
    @noun = fetch_noun('object')
    do_article = fetch_article('accusative', @noun.gender)
    verb = Verb.where(g_case: 'accu_dati').sample
    verb = fetch_verb(verb.preterit)

    { sentence: "#{@subject.value.capitalize} #{verb.value} #{io_article.value} #{io_noun.value} #{do_article.value} #{@noun.value.capitalize}",
      obfus: "#{@subject.value.capitalize} #{verb.value} #{io_article.value.split(//).map! { '_' }.join} #{io_noun.value.capitalize} #{do_article.value.split(//).map! { '_' }.join} #{@noun.value.capitalize}",
      english: "#{@subject.english.capitalize} #{verb.english} #{do_article.definite ? do_article.english : a_or_an(@noun)} #{@noun.english} #{io_article.definite ? io_article.english : a_or_an(io_noun, 'dative')} #{io_noun.english}",
      solution: [io_article.value, do_article.value] }
  end

  def conjug
    verb = Verb.where(person: @person_verb).sample
    { sentence: "#{@subject.value.capitalize} #{verb.value}",
      obfus: "#{@subject.value.capitalize} #{verb.value.split(//).map! { '_ ' }.join}",
      english: "#{@subject.english.capitalize} #{verb.english}",
      solution: [@verb.value] }
  end

  def definite_article(article)
    article.definite ? article.english : a_or_an(@noun)
  end

  def a_or_an(noun, dative = false)
    if dative
      @vowel.include?(noun.english[0]) ? '(to/for) an' : '(to/for) a'
    else
      @vowel.include?(noun.english[0]) ? 'an' : 'a'
    end
  end
end
