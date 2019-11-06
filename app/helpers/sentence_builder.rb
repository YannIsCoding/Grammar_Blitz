module SentenceBuilder
  def self.subject_verb(subject_person, verb_person)
    gpp = PersonalPronoun.where(person: subject_person).first.value
    verb = Verb.where(person: verb_person).first.value
    "#{gpp} #{verb}"
  end

  def self.article_noun(options = {})
    article = Article.where(options).first.value
    noun = Noun.where(options.except(:case, :definite)).sample.value
    "#{article} #{noun}"
  end
end
