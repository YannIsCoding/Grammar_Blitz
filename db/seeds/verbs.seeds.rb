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
      #
      %w[habe first_singular haben auxiliary have] << interactive_things,
      %w[hast second_singular haben auxiliary have] << interactive_things,
      %w[hat third_singular haben auxiliary has] << interactive_things,
      %w[haben first_plurial haben auxiliary have] << interactive_things,
      %w[habt second_plurial haben auxiliary have] << interactive_things,
      %w[haben third_plurial haben auxiliary have] << interactive_things,
      #
      %w[kenne first_singular kennen accusative know] << knowable_things,
      %w[kennst second_singular kennen accusative know] << knowable_things,
      %w[kennt third_singular kennen accusative knows] << knowable_things,
      %w[kennen first_plurial kennen accusative know] << knowable_things,
      %w[kennt second_plurial kennen accusative know] << knowable_things,
      %w[kennen third_plurial kennen accusative know] << knowable_things,
      #
      %w[will first_singular wollen accusative want] << interactive_things,
      %w[willst second_singular wollen accusative want] << interactive_things,
      %w[will third_singular wollen accusative wants] << interactive_things,
      %w[wollen first_plurial wollen accusative want] << interactive_things,
      %w[wollt second_plurial wollen accusative want] << interactive_things,
      %w[wollen third_plurial wollen accusative want] << interactive_things,
      #
      %w[sehe first_singular sehen accusative see] << seeable_things,
      %w[siehst second_singular sehen accusative see] << seeable_things,
      %w[sieht third_singular sehen accusative sees] << seeable_things,
      %w[sehen first_plurial sehen accusative see] << seeable_things,
      %w[seht second_plurial sehen accusative see] << seeable_things,
      %w[sehen third_plurial sehen accusative see] << seeable_things,
      #
      %w[mag first_singular mögen accusative like] << percievable_things,
      %w[magst second_singular mögen accusative like] << percievable_things,
      %w[mag third_singular mögen accusative likes] << percievable_things,
      %w[mögen first_plurial mögen accusative like] << percievable_things,
      %w[mögt second_plurial mögen accusative like] << percievable_things,
      %w[mögen third_plurial mögen accusative like] << percievable_things,
      #
      %w[trinke first_singular trinken accusative drink] << ['drink'],
      %w[trinkst second_singular trinken accusative drink] << ['drink'],
      %w[trinkt third_singular trinken accusative drinks] << ['drink'],
      %w[trinken first_plurial trinken accusative drink] << ['drink'],
      %w[trinkt second_plurial trinken accusative drink] << ['drink'],
      %w[trinken third_plurial trinken accusative drink] << ['drink'],
      #
      %w[antworte first_singular antworten dative answer] << %w[people],
      %w[antwortest second_singular antworten dative answer] << %w[people],
      %w[antwortet third_singular antworten dative answers] << %w[people],
      %w[antworten first_plurial antworten dative answer] << %w[people],
      %w[antwortet second_plurial antworten dative answer] << %w[people],
      %w[antworten third_plurial antworten dative answer] << %w[people],
      #
      %w[danke first_singular danken dative thank] << %w[people],
      %w[dankst second_singular danken dative thank] << %w[people],
      %w[dankt third_singular danken dative thanks] << %w[people],
      %w[danken first_plurial danken dative thank] << %w[people],
      %w[dankt second_plurial danken dative thank] << %w[people],
      %w[danken third_plurial danken dative thank] << %w[people],
      #
      %w[folge first_singular folgen dative follow] << %w[people],
      %w[folgst second_singular folgen dative follow] << %w[people],
      %w[folgt third_singular folgen dative follows] << %w[people],
      %w[folgen first_plurial folgen dative follow] << %w[people],
      %w[folgt second_plurial folgen dative follow] << %w[people],
      %w[folgen third_plurial folgen dative follow] << %w[people],
      #
      %w[kaufe first_singular kaufen accu_dati buy] << interactive_things,
      %w[kaufst second_singular kaufen accu_dati buy] << interactive_things,
      %w[kauft third_singular kaufen accu_dati buys] << interactive_things,
      %w[kaufen first_plurial kaufen accu_dati buy] << interactive_things,
      %w[kauft second_plurial kaufen accu_dati buy] << interactive_things,
      %w[kaufen third_plurial kaufen accu_dati buy] << interactive_things,
      #
      %w[gebe first_singular geben accu_dati give] << interactive_things,
      %w[gibst second_singular geben accu_dati give] << interactive_things,
      %w[gibt third_singular geben accu_dati gives] << interactive_things,
      %w[geben first_plurial geben accu_dati give] << interactive_things,
      %w[gebt second_plurial geben accu_dati give] << interactive_things,
      %w[geben third_plurial geben accu_dati give] << interactive_things,
      #
      %w[schicke first_singular schicken accu_dati send] << transportable_things,
      %w[schickst second_singular schicken accu_dati send] << transportable_things,
      %w[schickt third_singular schicken accu_dati sends] << transportable_things,
      %w[schicken first_plurial schicken accu_dati send] << transportable_things,
      %w[schickt second_plurial schicken accu_dati send] << transportable_things,
      %w[schicken third_plurial schicken accu_dati send] << transportable_things,
      #
      %w[bringe first_singular bringen accu_dati bring] << transportable_things,
      %w[bringst second_singular bringen accu_dati bring] << transportable_things,
      %w[bringt third_singular bringen accu_dati brings] << transportable_things,
      %w[bringen first_plurial bringen accu_dati bring] << transportable_things,
      %w[bringt second_plurial bringen accu_dati bring] << transportable_things,
      %w[bringen third_plurial bringen accu_dati bring] << transportable_things,
      #
      %w[schenke first_singular schenken accu_dati offer(gift)] << interactive_things,
      %w[schenkst second_singular schenken accu_dati offer(gift)] << interactive_things,
      %w[schenkt third_singular schenken accu_dati offers(gift)] << interactive_things,
      %w[schenken first_plurial schenken accu_dati offer(gift)] << interactive_things,
      %w[schenkt second_plurial schenken accu_dati offer(gift)] << interactive_things,
      %w[schenken third_plurial schenken accu_dati offer(gift)] << interactive_things,
      #
      %w[zeige first_singular zeigen accu_dati show] << seeable_things,
      %w[zeigst second_singular zeigen accu_dati show] << seeable_things,
      %w[zeigt third_singular zeigen accu_dati shows] << seeable_things,
      %w[zeigen first_plurial zeigen accu_dati show] << seeable_things,
      %w[zeigt second_plurial zeigen accu_dati show] << seeable_things,
      %w[zeigen third_plurial zeigen accu_dati show] << seeable_things,
     ]

verbs_check_array = []

verbs.each do |array|
  verbs_check_array << Verb.find_or_create_by!(
    value: array[0],
    person: array[1],
    preterit: array[2],
    g_case: array[3],
    english: array[4],
    go_with: array[5]
    )
end

delete_array = []
Verb.all.each do |verb|
  delete_array << verb.destroy if !verbs_check_array.include?(verb)
end

puts 'The following verbs were deleted because they were neither found or created:'
p delete_array

puts 'Verbs are seeded!'
