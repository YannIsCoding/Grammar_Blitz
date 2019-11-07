# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
Verb.delete_all
PersonalPronoun.delete_all
Article.delete_all
Noun.delete_all
StructureElement.delete_all
Element.delete_all
Exercice.delete_all
Structure.delete_all

User.create!(
  email: 'me@me.me',
  password: '123456'
  )


verbs = [
      %w[bin first_singular sein],
      %w[bist second_singular sein],
      %w[ist third_singular sein],
      %w[sind first_plurial sein],
      %w[seid second_plurial sein],
      %w[sind third_plurial sein]
      ]

verbs.each do |array|
  Verb.create!(
    value: array[0],
    person: array[1],
    preterit: array[2]
    )
end

pp = [%w[ich first_singular nominative],
      %w[du second_singular nominative],
      %w[er third_masculin nominative],
      %w[sie third_feminin nominative],
      %w[es third_neutral nominative],
      %w[wir first_plurial nominative],
      %w[ihr second_plurial nominative],
      %w[Sie third_plurial nominative],
  ]
pp.each do |array|
  PersonalPronoun.create!(
    value: array[0],
    person: array[1],
    case: array[2]
      )
end

da = [
  %w[der masculin nominative true],
  %w[die feminin nominative true],
  %w[das neutral nominative true],
  %w[die plurial nominative true]
  ]

da.each do |array|
  Article.create!(
    value: array[0],
    gender: array[1],
    case: array[2],
    definite: array[3] == 'true'
      )
end

noun = [
  %w[freund masculin],
  %w[mann masculin],
  %w[kellner masculin],
  %w[freundin feminin],
  %w[stadt feminin],
  %w[hand feminin],
  %w[hande plurial],
  %w[teile plurial],
  %w[manner plurial],
  %w[lander plurial],
  %w[auto neutral],
  %w[jahr neutral],
  %w[beispiel neutral],
  %w[haus neutral],
  %w[end neutral]
  ]

noun.each do |array|
  Noun.create!(
    value: array[0],
    gender: array[1],
      )
end

%w[subject verb OD OI preposition].each do |el|
  Element.create!(value: el)
end

%w[S_V_PREP_OD S_V_OD].each do |structure|
  Structure.create!(name: structure)
end

structure_elements = [
  %w[1 subject S_V_PREP_OD],
  %w[2 verb S_V_PREP_OD],
  %w[3 preposition S_V_PREP_OD],
  %w[4 OD S_V_PREP_OD],
  %w[1 subject S_V_OD],
  %w[2 verb S_V_OD],
  %w[3 OD S_V_OD]
]

structure_elements.each do |array|
  StructureElement.create!(
    position: array[0].to_i,
    element_id: Element.find_by(value: array[1]).id,
    structure_id: Structure.find_by(name: array[2]).id
    )
end

Exercice.create!(
  name: 'direct object and accusative',
  description: 'simple sentence structure with accusative and direct object',
  structure_id: Structure.find_by(name: 'S_V_OD').id
  )

puts ' IT IS DONE! '
