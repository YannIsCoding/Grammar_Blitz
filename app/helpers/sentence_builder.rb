module SentenceBuilder
  def self.subject_verb(subject_person, verb_person)
    pp = PersonalPronoun.where(person: subject_person).first.value
    verb = Verb.where(person: verb_person).first.value
    "#{pp} #{verb}"
  end

  def self.article_noun(options = {})
    article = Article.where(options).first.value
    noun = Noun.where(options.except(:case, :definite)).sample.value
    "#{article} #{noun}"
  end

  def self.person
    %w[first_singular
       second_singular
       third_masculin
       third_feminin
       third_neutral
       first_plurial
       second_plurial
       third_plurial].sample
  end
end
