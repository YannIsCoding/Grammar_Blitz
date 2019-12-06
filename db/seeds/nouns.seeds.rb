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
  %w[mutter feminin mother people],
  %w[Mädchen neutral girl people],
  %w[Mädchen plurial girls people],
  %w[Junge masculin boy people],
  %w[Jungen plurial boys people],
  %w[kerl masculin dude people],
  %w[kind neutral kid people],
  %w[Ehefrau feminin wife people],
  %w[Ehefrauen plurial wives people],
  %w[bruder masculin brother people],
  %w[sohn masculin son people],
  %w[Schwester feminin sister people],
  %w[Schwestern plurial sisters people],
  %w[Tochter feminin daugther people],
  #
  %w[stadt feminin city place],
  %w[länder plurial countries place],
  %w[weg masculin way place],
  %w[schule feminin school building],
  %w[amt neutral office building],
  %w[gebäude neutral building building],
  %w[haus neutral house building],
  %w[ort masculin place place],
  %w[Straße feminin street place],
  %w[Straßen plurial streets place],
  %w[Ecke feminin corner place],
  %w[Hölle feminin hell place],
  %w[Wohnung feminin apartement place],
  %w[Wohnungen plurial apartements place],
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
  %w[Essen neutral meal food],
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
  %w[ding neutral thing object],
  %w[Tabellen plurial tables object],
  %w[Telefon neutral phone object],
  %w[Telefone plurial phones object],
  %w[Stuhl masculin chair object],
  %w[Taschen plurial bags object],
  %w[Waffe feminin weapon object],
  %w[stein masculin stone object],
  %w[steine plurial stones object],
  #
  %w[hund masculin dog animal],
  %w[hunde plurial dogs animal],
  %w[katze feminin cat animal],
  %w[schildkröte feminin turtle animal],
  %w[pferd neutral horse animal],
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

nouns_check_array = []

noun.each do |array|
  nouns_check_array << Noun.find_or_create_by!(
    value: array[0],
    gender: array[1],
    english: array[2],
    kind: array[3]
      )
end

delete_array = []
Noun.all.each do |noun|
  delete_array << noun.destroy if !nouns_check_array.include?(noun)
end

puts 'The following nouns were deleted because they were neither found or created:'
p delete_array

puts 'Nouns are seeded!'
