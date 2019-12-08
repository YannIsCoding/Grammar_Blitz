class SentenceBuilderService
  attr_reader :g_case, :person, :genders, :gender, :verb, :subject, :article, :noun, :preposition
  def initialize(exercice)
    @exercice = exercice
    @vowel = ('aeiou')
    @g_case = @exercice.structure.name == 's_v_do_dative' ? 'dative' : 'accusative'
    @person = Pronoun.where(kind: 'personal').map(&:person).uniq.sample
    @person_verb = fetch_person_verb(@person)
    # @gender = fetch_gender
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
    personal_pronoun = Pronoun.find_by(person: @person, kind: 'personal')
    raise "No personal pronoun found with person #{@person}" if personal_pronoun.nil?

    personal_pronoun
  end

  def pick_determiner(g_case, gender, negation = false)
    if rand(2).positive?
      fetch_article(g_case, gender, negation: negation)
    else
      fetch_possessive_pronoun(g_case, gender)
    end
  end

  def fetch_article(g_case, gender, options = {})
    articles = Article.where(g_case: g_case, gender: gender)
    articles = articles.where(negation: options[:negation]) unless options[:negation].nil?
    articles = articles.where(definite: options[:definite]) unless options[:definite].nil?
    article = articles.sample
    raise "No Article found with gender #{gender}, g_case #{g_case} and definite #{@definite_article}" if article.nil?

    article
  end

  def fetch_possessive_pronoun(g_case, gender)
    possessive_pronoun = Pronoun.where(kind: 'possessive', gender: gender, g_case: g_case).sample
    raise "No possessive pronoun found with gender #{gender}, g_case #{g_case}" if possessive_pronoun.nil?

    possessive_pronoun
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

    determiner = pick_determiner(g_case, noun.gender, negation)
    verb = fetch_verb(g_case, noun)
    fetch_sentence(subject, verb, determiner, noun, negation)
  end

  def fetch_sentence(subject, verb, determiner, noun, negation)
    { sentence: subject.to_s.capitalize + " #{verb} #{determiner} #{noun} #{nicht_or_not(determiner, negation)}",
      english: "#{subject.english} #{negation ? dont_or_doesnt(@person_verb, verb) : verb.english} #{english_article(determiner, noun)} #{noun.english}".capitalize,
      hide_index: [2] }
  end

  def s_v_do_dative
    s_v_do('dative')
  end

  def s_v_prep_do
    negation = Article.all.map(&:negation).uniq.sample # return true or false
    subject = fetch_subject
    noun = fetch_noun(@noun_kind)
    determiner = pick_determiner(g_case, noun.gender, negation)
    verb = fetch_verb(g_case, noun)
    { sentence: subject.to_s.capitalize + " #{verb} #{preposition} #{determiner} #{noun}",
      english: "#{subject.english} #{verb.english} #{preposition.english} #{english_article(determiner, noun)} #{noun.english}".capitalize,
      hide_index: [3] }
  end

  def v_s_do
    subject = fetch_subject
    noun = fetch_noun(@noun_kind)
    determiner = pick_determiner(g_case, noun.gender)
    verb = fetch_verb(g_case, noun)
    { sentence: verb.to_s.capitalize + " #{subject} #{determiner} #{noun}?",
      english: "#{do_or_does(@person_verb)} #{subject.english} #{@person_verb == 'third_singular' ? remove_the_s(verb.english) : verb.english} #{english_article(determiner, noun)} #{noun.english}?",
      hide_index: [2] }
  end

  def s_v_io_do
    negation = Article.all.map(&:negation).uniq.sample # return true or false
    subject = fetch_subject
    io_noun = fetch_noun('people')
    io_determiner = pick_determiner('dative', io_noun.gender)
    noun = fetch_noun('object')
    do_determiner = fetch_article('accusative', noun.gender, negation: negation)
    verb = fetch_verb('accu_dati', noun)
    { sentence: subject.to_s.capitalize + " #{verb} #{io_determiner} #{io_noun} #{do_determiner} #{noun} #{nicht_or_not(do_determiner, negation)}",
      english: "#{subject.english} #{negation ? dont_or_doesnt(@person_verb, verb) : verb.english} #{english_article(do_determiner, noun)} #{noun.english} (to/for) #{english_article(io_determiner, io_noun, 'dative')} #{io_noun.english}".capitalize,
      hide_index: [2, 4] }
  end

  def conjug
    verb = Verb.where(person: @person_verb).sample
    { sentence: "#{@subject} #{verb}".capitalize,
      english: "#{@subject.english} #{verb.english}".capitalize,
      hide_index: [1] }
  end


  def english_article(determiner, noun, dative = false)
    if determiner.is_a?(Article)
      determiner.definite ? determiner.english : a_or_an(noun, dative)
    else
      determiner.english
    end
  end

  def a_or_an(noun, dative)
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

  def nicht_or_not(determiner, negation)
    if determiner.is_a?(Article)
      'nicht' if negation && determiner&.definite
    elsif negation
      'nicht'
    end
  end

end
