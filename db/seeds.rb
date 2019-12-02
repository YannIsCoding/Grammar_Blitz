# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# User.delete_all
VerbNounLink.delete_all
Verb.delete_all
Noun.delete_all
PersonalPronoun.delete_all
Article.delete_all
# Preposition.delete_all
# StructureElement.delete_all
# Element.delete_all
# Exercice.delete_all
# Structure.delete_all

# url = "https://www.scienceabc.com/wp-content/uploads/2015/12/alan-turing.jpg"
# u = User.create!(
#   email: 'me@me.me',
#   password: '123456',
#   username: 'Alan'
#   )
# u.remote_photo_url = url
# u.save

seeable_things = %w[object vehicule animal food building people]
hearable_things = %w[vehicule animal sound people]
percievable_things = (seeable_things + hearable_things).uniq
interactive_things = %w[object vehicule animal food building]
transportable_things = %w[object vehicule animal food]
knowable_things = %w[people place object]

verbs = [
      %w[bin first_singular sein auxiliary am] << %w[people],
      %w[bist second_singular sein auxiliary are] << %w[people],
      %w[ist third_singular sein auxiliary is] << %w[people],
      %w[sind first_plurial sein auxiliary are] << %w[people],
      %w[seid second_plurial sein auxiliary are] << %w[people],
      %w[sind third_plurial sein auxiliary are] << %w[people],
      # %w[habe first_singular haben auxiliary have] << interactive_things,
      # %w[hast second_singular haben auxiliary have] << interactive_things,
      # %w[hat third_singular haben auxiliary has] << interactive_things,
      # %w[haben first_plurial haben auxiliary have] << interactive_things,
      # %w[habt second_plurial haben auxiliary have] << interactive_things,
      # %w[haben third_plurial haben auxiliary have] << interactive_things,
      %w[kenne first_singular kennen accusative know] << knowable_things,
      %w[kennst second_singular kennen accusative know] << knowable_things,
      %w[kennt third_singular kennen accusative knows] << knowable_things,
      %w[kennen first_plurial kennen accusative know] << knowable_things,
      %w[kennt second_plurial kennen accusative know] << knowable_things,
      %w[kennen third_plurial kennen accusative know] << knowable_things,
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
      %w[trinke first_singular trinken accusative drink] << ['drink'],
      %w[trinkst second_singular trinken accusative drink] << ['drink'],
      %w[trinkt third_singular trinken accusative drinks] << ['drink'],
      %w[trinken first_plurial trinken accusative drink] << ['drink'],
      %w[trinkt second_plurial trinken accusative drink] << ['drink'],
      %w[trinken third_plurial trinken accusative drink] << ['drink'],
      %w[antworte first_singular antworten dative answer] << %w[people],
      %w[antwortest second_singular antworten dative answer] << %w[people],
      %w[antwortet third_singular antworten dative answers] << %w[people],
      %w[antworten first_plurial antworten dative answer] << %w[people],
      %w[antwortet second_plurial antworten dative answer] << %w[people],
      %w[antworten third_plurial antworten dative answer] << %w[people],
      %w[danke first_singular danken dative thank] << %w[people],
      %w[dankst second_singular danken dative thank] << %w[people],
      %w[dankt third_singular danken dative thanks] << %w[people],
      %w[danken first_plurial danken dative thank] << %w[people],
      %w[dankt second_plurial danken dative thank] << %w[people],
      %w[danken third_plurial danken dative thank] << %w[people],
      %w[folge first_singular folgen dative follow] << %w[people],
      %w[folgst second_singular folgen dative follow] << %w[people],
      %w[folgt third_singular folgen dative follows] << %w[people],
      %w[folgen first_plurial folgen dative follow] << %w[people],
      %w[folgt second_plurial folgen dative follow] << %w[people],
      %w[folgen third_plurial folgen dative follow] << %w[people],

      %w[kaufe first_singular kaufen accu_dati buy] << interactive_things,
      %w[kaufst second_singular kaufen accu_dati buy] << interactive_things,
      %w[kauft third_singular kaufen accu_dati buys] << interactive_things,
      %w[kaufen first_plurial kaufen accu_dati buy] << interactive_things,
      %w[kauft second_plurial kaufen accu_dati buy] << interactive_things,
      %w[kaufen third_plurial kaufen accu_dati buy] << interactive_things,
      %w[gebe first_singular geben accu_dati give] << interactive_things,
      %w[gibst second_singular geben accu_dati give] << interactive_things,
      %w[gibt third_singular geben accu_dati gives] << interactive_things,
      %w[geben first_plurial geben accu_dati give] << interactive_things,
      %w[gebt second_plurial geben accu_dati give] << interactive_things,
      %w[geben third_plurial geben accu_dati give] << interactive_things,
      %w[schicke first_singular schicken accu_dati send] << transportable_things,
      %w[schickst second_singular schicken accu_dati send] << transportable_things,
      %w[schickt third_singular schicken accu_dati sends] << transportable_things,
      %w[schicken first_plurial schicken accu_dati send] << transportable_things,
      %w[schickt second_plurial schicken accu_dati send] << transportable_things,
      %w[schicken third_plurial schicken accu_dati send] << transportable_things,
      %w[bringe first_singular bringen accu_dati bring] << transportable_things,
      %w[bringst second_singular bringen accu_dati bring] << transportable_things,
      %w[bringt third_singular bringen accu_dati brings] << transportable_things,
      %w[bringen first_plurial bringen accu_dati bring] << transportable_things,
      %w[bringt second_plurial bringen accu_dati bring] << transportable_things,
      %w[bringen third_plurial bringen accu_dati bring] << transportable_things,
      %w[schenke first_singular schenken accu_dati offer(gift)] << interactive_things,
      %w[schenkst second_singular schenken accu_dati offer(gift)] << interactive_things,
      %w[schenkt third_singular schenken accu_dati offers(gift)] << interactive_things,
      %w[schenken first_plurial schenken accu_dati offer(gift)] << interactive_things,
      %w[schenkt second_plurial schenken accu_dati offer(gift)] << interactive_things,
      %w[schenken third_plurial schenken accu_dati offer(gift)] << interactive_things,
      %w[zeige first_singular zeigen accu_dati show] << seeable_things,
      %w[zeigst second_singular zeigen accu_dati show] << seeable_things,
      %w[zeigt third_singular zeigen accu_dati shows] << seeable_things,
      %w[zeigen first_plurial zeigen accu_dati show] << seeable_things,
      %w[zeigt second_plurial zeigen accu_dati show] << seeable_things,
      %w[zeigen third_plurial zeigen accu_dati show] << seeable_things,
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
  %w[fahrer masculin driver people],
  %w[frau feminin woman people],
  %w[kellner masculin waiter people],
  %w[freundin feminin friend(fem.) people],
  %w[feuerwehrfrau feminin firefighter(fem.) people],
  %w[Ärztin feminin doctor(fem.) people],
  %w[Anwältin  feminin lawyer(fem.) people],
  %w[frauen plurial women people],
  #
  %w[stadt feminin city place],
  %w[lander plurial countries place],
  %w[weg masculin way place],
  %w[schule feminin school building],
  %w[amt neutral office building],
  %w[gebäude neutral building building],
  %w[haus neutral house building],
  #
  %w[auto neutral car vehicule],
  %w[fahrrad neutral bike vehicule],
  #
  %w[pizza feminin pizza food],
  %w[kurbis masculin pumpkin food],
  %w[bratwurst feminin sausage food],
  %w[bohne plurial beans food],
  %w[nudeln plurial pasta food],
  %w[brot neutral bread food],
  %w[wasser neutral water drink],
  %w[tee masculin tea drink],
  %w[kaffee masculin coffee drink],
  %w[saft masculin juice drink],
  %w[bier neutral bier drink],
  #
  %w[Tür feminin door object],
  %w[teile plurial parts object],
  %w[tisch masculin table object],
  %w[bett neutral bed object],
  %w[buch neutral book object],
  %w[schutzhelm masculin helmet object],
  %w[handy neutral cellular object],
  %w[baum masculin tree object],
  %w[papier neutral paper object],
  %w[beutel masculin bag object],
  %w[kiste feminin box object],
  %w[Stück neutral piece object],
  #
  %w[hund masculin dog animal],
  %w[katze feminin cat animal],
  %w[schildkröte feminin turtle animal],
  #
  %w[klang masculin sound sound],
  %w[musik feminin music sound],
  %w[alarm masculin alarm sound],
  %w[stimme feminin voice sound],
  %w[stoizismus masculin stoicism idea],
  %w[philosophie feminin philosophy idea],
  %w[maskottchen neutral mascot idea],
  %w[steuern plurial taxes idea],
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
    kind: array[3]
      )
end
noun_instances = Noun.all
verb_instances = Verb.all
verb_instances.each do |verb|
  noun_instances.each do |noun|
    if verb.go_with.include?(noun.kind)
      VerbNounLink.create!(
        verb: verb,
        noun: noun
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

articles = [
  %w[der masculin nominative true the],
  %w[die feminin nominative true the],
  %w[das neutral nominative true the],
  %w[die plurial nominative true the],
  %w[ein masculin nominative false a/an],
  %w[eine feminin nominative false a/an],
  %w[ein neutral nominative false a/an],
  #
  %w[den masculin accusative true the],
  %w[das neutral accusative true the],
  %w[die feminin accusative true the],
  %w[die plurial accusative true the],
  %w[einen masculin accusative false a/an],
  %w[ein neutral accusative false a/an],
  %w[eine feminin accusative false a/an],
  #
  %w[dem masculin dative true] << '(to/for) the',
  %w[dem neutral dative true] << '(to/for) the',
  %w[der feminin dative true] << '(to/for) the',
  %w[den plurial dative true] << '(to/for) the',
  %w[einem masculin dative false] << '(to/for) a/an',
  %w[einem neutral dative false] << '(to/for) a/an',
  %w[einer feminin dative false] << '(to/for) a/an',
  ]

articles.each do |article|
  Article.create!(
    value: article[0],
    gender: article[1],
    g_case: article[2],
    definite: article[3] == 'true',
    english: article[4]
      )
end

# prep = [
#   # %w[durch accusative through] << %w[sehen gehen], # verb: mouvement noun:place
#   ['für', 'accusative', 'for', ['sein'], ['idea']], # verb: be noun: people
#   ['gegen', 'accusative', 'against', ['sein'], ['idea']] # verb: be noun: vehicule, food
#   # %w[ohne accusative without],<< %w[sein] #verb: be buy noun: people vehicule food
#   # %w[um accusative around] #verb: buy noun: time
# ]

# prep.each do |array|
#   Preposition.create!(
#     value: array[0],
#     g_case: array[1],
#     english: array[2],
#     verbs: array[3],
#     kind_nouns: array[4]
#     )
# end


# %w[subject verb do io preposition].each do |el|
#   Element.create!(value: el)
# end

# %w[s_v_prep_do s_v_do v_s_do s_v_do_dative s_v_io_do conjug].each do |structure|
#   Structure.create!(name: structure)
# end
# %w[conjug].each do |structure|
#   Structure.create!(name: structure)
# end
# structure_elements = [
#   %w[1 subject s_v_prep_do],
#   %w[2 verb s_v_prep_do],
#   %w[3 preposition s_v_prep_do],
#   %w[4 do s_v_prep_do],
#   %w[1 subject s_v_do],
#   %w[2 verb s_v_do],
#   %w[3 do s_v_do]
# ]

# structure_elements.each do |array|
#   StructureElement.create!(
#     position: array[0].to_i,
#     element_id: Element.find_by(value: array[1]).id,
#     structure_id: Structure.find_by(name: array[2]).id
#     )
# end

# Exercice.create!(
#   name: 'Sentence with direct object and accusative',
#   description: 'simple sentence structure with accusative and direct object',
#   structure: Structure.find_by(name: 's_v_do')
#   )
# # Exercice.create!(
# #   name: 'Sentence with direct object and accusative with preposition',
# #   description: 'simple sentence structure with accusative and preposition',
# #   structure: Structure.find_by(name: 's_v_prep_do')
# #   )
# Exercice.create!(
#   name: ' Questions with direct object and accusative',
#   description: 'Questions with accusative and preposition',
#   structure: Structure.find_by(name: 'v_s_do')
#   )
# Exercice.create!(
#   name: ' Sentence with direct object and dative',
#   description: 'Sentence with dative and preposition',
#   structure: Structure.find_by(name: 's_v_do_dative')
#   )
# Exercice.create!(
#   name: ' Sentence with direct and indirect object ',
#   description: 'Sentence with direct and indirect object',
#   structure: Structure.find_by(name: 's_v_io_do')
#   )
# Exercice.create!(
#   name: 'Conjugation practice',
#   description: 'Practice conjugaison on all sort of verbs',
#   structure: Structure.find_by(name: 'conjug')
#   )

puts ' IT IS DONE! '
