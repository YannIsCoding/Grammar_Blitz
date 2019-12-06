class SentenceBuilderService
  attr_reader :g_case, :person, :genders, :gender, :verb, :subject, :article, :noun, :preposition
  def initialize(exercice)
    @exercice = exercice
    @vowel = ('aeiou')
    @g_case = @exercice.structure.name == 's_v_do_dative' ? 'dative' : 'accusative'
    @person = PersonalPronoun.all.map(&:person).uniq.sample
    @person_verb = fetch_person_verb(@person)
    @gender = fetch_gender
  end

  def generate
    @preposition = fetch_preposition if @exercice.structure.name == 's_v_prep_do'
    @subject = fetch_subject
    if @exercice.structure.name == 's_v_io_do'
      send(@exercice.structure.name)
    else
      if @exercice.structure.name == 's_v_do_dative'
        @noun_kind = 'people'
      elsif @preposition
        @noun_kind = 'idea'
      else
        @noun_kind = Noun.all.map(&:kind).uniq.reject { |n| n == 'idea' }.sample
      end
      @noun = fetch_noun(@noun_kind)
      @article = fetch_article(@g_case, @noun.gender)
      send(@exercice.structure.name)
    end
  end

  private

  def fetch_preposition
    preposition = Preposition.where(g_case: @g_case).sample
    raise "No preposition found with g_case #{g_case}" if preposition.nil?

    preposition
  end

  def fetch_person_verb(person)
    if person == 'third_masculin' || person == 'third_feminin'
      person_verb = 'third_singular'
    else
      person_verb = person
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

  def fetch_article(g_case, gender, options = {})
    articles = Article.where(g_case: g_case, gender: gender)
    articles = articles.where(negation: options[:negation]) unless options[:negation].nil?
    articles = articles.where(definite: options[:definite]) unless options[:definite].nil?
    article = articles.sample
    raise "No Article found with gender #{gender}, g_case #{g_case} and definite #{@definite_article}" if article.nil?

    article
  end

  def fetch_noun(noun_kind)
    noun = Noun.where(kind: noun_kind).sample
    raise "No noun found with the kind of noun #{noun_kind}" if noun.nil?

    noun
  end

  def fetch_verb(g_case, noun)
    if @preposition
      verb = Verb.where(preterit: @preposition.verbs.sample, person: @person_verb).sample
      raise "No verb found with the preposition #{@preposition.value} only accept: #{@preposition.verbs} person #{@person_verb}" if verb.nil?
    else
      verb = noun.verbs.where(person: @person_verb, g_case: g_case).sample
      raise "No verb found with the noun #{noun.value}, person #{@person_verb} and g_case #{g_case}" if verb.nil?
    end

    verb
  end

  def s_v_do(g_case = 'accusative')
    negation = Article.all.map(&:negation).uniq.sample # return true or false
    subject = fetch_subject
    noun = fetch_noun(@noun_kind)
    article = fetch_article(g_case, noun.gender, negation: negation)
    verb = fetch_verb(g_case, noun)
    fetch_sentence(subject, verb, article, noun)
  end

  def s_v_do_dative
    s_v_do('dative')
  end

  def s_v_prep_do
    subject = fetch_subject
    noun = fetch_noun(@noun_kind)
    article = fetch_article(g_case, noun.gender)
    verb = fetch_verb(g_case, noun)
    { sentence: subject.to_s.capitalize + " #{verb} #{preposition} #{article} #{noun}",
      hide_index: [3],
      english: "#{subject.english} #{verb.english} #{preposition.english} #{english_article(article, noun)} #{noun.english}".capitalize }
  end

  def v_s_do
    subject = fetch_subject
    noun = fetch_noun(@noun_kind)
    article = fetch_article(g_case, noun.gender, negation: false)
    verb = fetch_verb(g_case, noun)
    { sentence: verb.to_s.capitalize + " #{subject} #{article} #{noun}?",
      hide_index: [2],
      english: "#{do_or_does(@person_verb)} #{subject.english} #{@person_verb == 'third_singular' ? remove_the_s(verb.english) : verb.english} #{english_article(article, noun)} #{noun.english}?" }
  end

  def s_v_io_do
    negation = Article.all.map(&:negation).uniq.sample # return true or false
    subject = fetch_subject
    io_noun = fetch_noun('people')
    io_article = fetch_article('dative', io_noun.gender, negation: false)
    noun = fetch_noun('object')
    do_article = fetch_article('accusative', noun.gender, negation: negation)
    verb = fetch_verb('accu_dati', noun)
    { sentence: subject.to_s.capitalize + " #{verb} #{io_article} #{io_noun} #{do_article} #{noun} #{nicht_or_not(do_article)}".capitalize,
      hide_index: [2, 4],
      english: "#{subject.english} #{negation ? dont_or_doesnt(@person_verb, verb) : verb.english} #{english_article(do_article, noun)} #{noun.english} #{io_article.definite ? io_article.english : a_or_an(io_noun, 'dative')} #{io_noun.english}".capitalize}
  end

  def conjug
    verb = Verb.where(person: @person_verb).sample
    { sentence: "#{@subject} #{verb}".capitalize,
      hide_index: [1],
      english: "#{@subject.english} #{verb.english}".capitalize}
  end

  def fetch_sentence(subject, verb, article, noun)
    { sentence: subject.to_s.capitalize + " #{verb} #{article} #{noun} #{nicht_or_not(article)}",
      hide_index: [2],
      english: "#{subject.english} #{article.negation ? dont_or_doesnt(@person_verb, verb) : verb.english} #{english_article(article, noun)} #{noun.english}".capitalize}
  end

  def english_article(article, noun)
    article.definite ? article.english : a_or_an(noun)
  end

  def a_or_an(noun, dative = false)
    if dative
      @vowel.include?(noun.english[0]) ? '(to/for) an' : '(to/for) a'
    else
      @vowel.include?(noun.english[0]) ? 'an' : 'a'
    end
  end

  def do_or_does(person)
    person == 'third_singular' ? 'Does' : 'Do'
  end

  def dont_or_doesnt(person, verb)
    person == 'third_singular' ? "doesn't #{remove_the_s(verb.english)}" : "don't #{verb.english}"
  end

  def remove_the_s(english_verb)
    english_verb[0..-2]
  end

  def nicht_or_not(article)
    'nicht' if article.negation && article.definite
  end
end
