class Person
  PERSONS = ["first_singular", "second_singular", "third_masculin", "third_feminin",
             "first_plurial", "second_plurial", "third_plurial"]

  def self.fetch(person)
    if person == 'third_singular'
      PERSONS[2, 2].sample
    else
      person
    end
  end
end
