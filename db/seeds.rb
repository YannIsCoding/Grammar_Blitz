# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ProgressTracker.delete_all
User.delete_all
VerbNounLink.delete_all
Verb.delete_all
Noun.delete_all
PersonalPronoun.delete_all
Article.delete_all
StructureElement.delete_all
Element.delete_all
Exercice.delete_all
Structure.delete_all

User.create!(
  email: 'me@me.me',
  password: '123456'
  )

verbs = [
      %w[bin first_singular sein auxiliary am] << %w[people],
      %w[bist second_singular sein auxiliary are] << %w[people],
      %w[ist third_singular sein auxiliary is] << %w[people],
      %w[sind first_plurial sein auxiliary are] << %w[people],
      %w[seid second_plurial sein auxiliary are] << %w[people],
      %w[sind third_plurial sein auxiliary are] << %w[people],
      %w[kenne first_singular kennen accusative know] << %w[people place object],
      %w[kennst second_singular kennen accusative know] << %w[people place object],
      %w[kennt third_singular kennen accusative knows] << %w[people place object],
      %w[kennen first_plurial kennen accusative know] << %w[people place object],
      %w[kennt second_plurial kennen accusative know] << %w[people place object],
      %w[kennen third_plurial kennen accusative know] << %w[people place object],
      %w[kaufe first_singular kaufen accusative buy] << %w[food object animal vehicule building],
      %w[kaufst second_singular kaufen accusative buy] << %w[food object animal vehicule building],
      %w[kauft third_singular kaufen accusative buys] << %w[food object animal vehicule building],
      %w[kaufen first_plurial kaufen accusative buy] << %w[food object animal vehicule building],
      %w[kauft second_plurial kaufen accusative buy] << %w[food object animal vehicule building],
      %w[kaufen third_plurial kaufen accusative buy] << %w[food object animal vehicule building]
      ]

verbs.each do |array|
  Verb.create!(
    value: array[0],
    person: array[1],
    preterit: array[2],
    g_case: array[3],
    english: array[4],
    go_with: array[5]
    )
end

noun = [
  %w[freund masculin friend people],
  %w[mann masculin man people],
  %w[kellner masculin waiter people],
  %w[freundin feminin friend people],
  %w[stadt feminin city place],
  %w[hand feminin hand],
  %w[hande plurial hands body],
  %w[teile plurial parts object],
  %w[manner plurial men people],
  %w[lander plurial countries place],
  %w[auto neutral car vehicule],
  %w[jahr neutral year time],
  %w[pizza feminin pizza food],
  %w[kurbis masculin pumpkin food],
  %w[haus neutral house building],
  ]

noun.each do |array|
  Noun.create!(
    value: array[0],
    gender: array[1],
    english: array[2],
    is_a: array[3]
      )
end
noun_instances = Noun.all
verb_instances = Verb.all
verb_instances.each do |verb|
  noun_instances.each do |noun|
    if verb.go_with.include?(noun.is_a)
      VerbNounLink.create!(
        verb_id: verb.id,
        noun_id: noun.id
        )
    end
  end
end

pp = [%w[ich first_singular nominative I],
      %w[du second_singular nominative you],
      %w[er third_masculin nominative he],
      %w[sie third_feminin nominative she],
      %w[wir first_plurial nominative we],
      %w[ihr second_plurial nominative you],
      %w[Sie third_plurial nominative they],
  ]
pp.each do |array|
  PersonalPronoun.create!(
    value: array[0],
    person: array[1],
    case: array[2],
    english: array[3]
      )
end

da = [
  %w[der masculin nominative true],
  %w[die feminin nominative true],
  %w[das neutral nominative true],
  %w[die plurial nominative true],
  %w[den masculin accusative true],
  %w[das neutral accusative true],
  %w[die feminin accusative true],
  %w[die plurial accusative true]
  ]

da.each do |array|
  Article.create!(
    value: array[0],
    gender: array[1],
    case: array[2],
    definite: array[3] == 'true',
    english: 'the'
      )
end


%w[subject verb od oi preposition].each do |el|
  Element.create!(value: el)
end

%w[S_V_PREP_OD S_V_OD].each do |structure|
  Structure.create!(name: structure)
end

structure_elements = [
  %w[1 subject S_V_PREP_OD],
  %w[2 verb S_V_PREP_OD],
  %w[3 preposition S_V_PREP_OD],
  %w[4 od S_V_PREP_OD],
  %w[1 subject S_V_OD],
  %w[2 verb S_V_OD],
  %w[3 od S_V_OD]
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
