class VerbPractice < SentenceBuilderService
  PERSONS = ["first_singular", "second_singular", "third_masculin", "third_feminin",
             "first_plurial", "second_plurial", "third_plurial"]

  def initialize(preterit:)
    @preterit = preterit
    @person = PERSONS.sample
    @subject = Pronoun.find_by(person: @person, kind: 'personal', g_case: 'nominative')
  end

  def generate
    verb = Verb.find_by(preterit: @preterit, person: fetch_person_verb(@person))
    @value = { value: "#{@subject} #{verb}".capitalize,
               english: "#{@subject.english} #{verb.english}".capitalize }
  end
end
