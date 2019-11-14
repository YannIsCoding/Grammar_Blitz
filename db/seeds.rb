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
Preposition.delete_all
StructureElement.delete_all
Element.delete_all
Exercice.delete_all
Structure.delete_all

User.create!(
  email: 'me@me.me',
  password: '123456'
  )

seeable_things = %w[object vehicule animal food building people]
hearable_things = %w[vehicule animal sound people]
percievable_things = (seeable_things + hearable_things).uniq
interactive_things = %w[object vehicule animal food building]
knowable_things = %w[people place object]

verbs = [
      # %w[bin first_singular sein auxiliary am] << %w[people],
      # %w[bist second_singular sein auxiliary are] << %w[people],
      # %w[ist third_singular sein auxiliary is] << %w[people],
      # %w[sind first_plurial sein auxiliary are] << %w[people],
      # %w[seid second_plurial sein auxiliary are] << %w[people],
      # %w[sind third_plurial sein auxiliary are] << %w[people],
      %w[habe first_singular haben auxiliary have] << interactive_things,
      %w[hast second_singular haben auxiliary have] << interactive_things,
      %w[hat third_singular haben auxiliary has] << interactive_things,
      %w[haben first_plurial haben auxiliary have] << interactive_things,
      %w[habt second_plurial haben auxiliary have] << interactive_things,
      %w[haben third_plurial haben auxiliary have] << interactive_things,
      %w[kenne first_singular kennen accusative know] << knowable_things,
      %w[kennst second_singular kennen accusative know] << knowable_things,
      %w[kennt third_singular kennen accusative knows] << knowable_things,
      %w[kennen first_plurial kennen accusative know] << knowable_things,
      %w[kennt second_plurial kennen accusative know] << knowable_things,
      %w[kennen third_plurial kennen accusative know] << knowable_things,
      %w[kaufe first_singular kaufen accusative buy] << interactive_things,
      %w[kaufst second_singular kaufen accusative buy] << interactive_things,
      %w[kauft third_singular kaufen accusative buys] << interactive_things,
      %w[kaufen first_plurial kaufen accusative buy] << interactive_things,
      %w[kauft second_plurial kaufen accusative buy] << interactive_things,
      %w[kaufen third_plurial kaufen accusative buy] << interactive_things,
      %w[gebe first_singular geben accusative give] << interactive_things,
      %w[gibst second_singular geben accusative give] << interactive_things,
      %w[gibt third_singular geben accusative gives] << interactive_things,
      %w[geben first_plurial geben accusative give] << interactive_things,
      %w[gebt second_plurial geben accusative give] << interactive_things,
      %w[geben third_plurial geben accusative give] << interactive_things,
      %w[will first_singular wollen accusative want] << interactive_things,
      %w[willst second_singular wollen accusative want] << interactive_things,
      %w[will third_singular wollen accusative wants] << interactive_things,
      %w[wollen first_plurial wollen accusative want] << interactive_things,
      %w[wollt second_plurial wollen accusative want] << interactive_things,
      %w[wollen third_plurial wollen accusative want] << interactive_things,
      %w[sehe first_singular sehen accusative see] << seeable_things,
      %w[siehst second_singular sehen accusative see] << seeable_things,
      %w[sieht third_singular sehen accusative sees] << seeable_things,
      %w[sehen first_plurial sehen accusative see] << seeable_things,
      %w[seht second_plurial sehen accusative see] << seeable_things,
      %w[sehen third_plurial sehen accusative see] << seeable_things,
      %w[mag first_singular mögen accusative like] << percievable_things,
      %w[magst second_singular mögen accusative like] << percievable_things,
      %w[mag third_singular mögen accusative likes] << percievable_things,
      %w[mögen first_plurial mögen accusative like] << percievable_things,
      %w[mögt second_plurial mögen accusative like] << percievable_things,
      %w[mögen third_plurial mögen accusative like] << percievable_things,
      %w[trink first_singular trinken accusative drink] << ['drink'],
      %w[trinkst second_singular trinken accusative drink] << ['drink'],
      %w[trinkt third_singular trinken accusative drinks] << ['drink'],
      %w[trinken first_plurial trinken accusative drink] << ['drink'],
      %w[trinkt second_plurial trinken accusative drink] << ['drink'],
      %w[trinken third_plurial trinken accusative drink] << ['drink'],
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
  %w[frau feminin woman people],
  %w[kellner masculin waiter people],
  %w[freundin feminin friend people],
  %w[stadt feminin city place],
  %w[teile plurial parts object],
  %w[manner plurial men people],
  %w[lander plurial countries place],
  %w[weg masculin way place],
  %w[auto neutral car vehicule],
  %w[pizza feminin pizza food],
  %w[kurbis masculin pumpkin food],
  %w[haus neutral house building],
  %w[Tür feminin door object],
  %w[tisch masculin table object],
  %w[bett neutral bed object],
  %w[schule feminin school building],
  %w[baum masculin tree object],
  %w[hund masculin dog animal],
  %w[papier neutral paper object],
  %w[gebäude neutral building building],
  %w[beutel masculin bag object],
  %w[kiste feminin box object],
  %w[Stück neutral piece object],
  %w[klang masculin sound sound],
  %w[wasser neutral water drink],
  %w[saft masculin juice drink],
  ]
  # %w[glas neutral glass drink/object]
  # %w[buch neutral book readable]
  # %w[arbeit feminin work activity]
  # %w[geschichte feminin story language]
  # %w[gott masculin god concept/divinity]
  # %w[jahr neutral year time],
  # %w[hand feminin hand body],
  # %w[hande plurial hands body],

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
    g_case: array[2],
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
    g_case: array[2],
    definite: array[3] == 'true',
    english: 'the'
      )
end

prep = [
  %w[durch accusative through], # verb: mouvement noun:place
  %w[für accusative for], # verb: be noun: people
  %w[gegen accusative against], # verb: be noun: vehicule, food
  %w[ohne accusative without], #verb: be buy noun: people vehicule food
  %w[um accusative around] #verb: buy noun: time
]

prep.each do |array|
  Preposition.create!(
    value: array[0],
    g_case: array[1],
    english: array[2]
    )
end


%w[subject verb do io preposition].each do |el|
  Element.create!(value: el)
end

%w[s_v_prep_do s_v_do].each do |structure|
  Structure.create!(name: structure)
end

structure_elements = [
  %w[1 subject s_v_prep_do],
  %w[2 verb s_v_prep_do],
  %w[3 preposition s_v_prep_do],
  %w[4 do s_v_prep_do],
  %w[1 subject s_v_do],
  %w[2 verb s_v_do],
  %w[3 do s_v_do]
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
  structure_id: Structure.find_by(name: 's_v_do').id
  )
Exercice.create!(
  name: 'direct object and accusative with preposition',
  description: 'simple sentence structure with accusative and preposition',
  structure_id: Structure.find_by(name: 's_v_prep_do').id
  )

puts ' IT IS DONE! '
