require 'seed_cleaner'
pronouns = [%w[ich first_singular nominative I personal],
            %w[du second_singular nominative you personal],
            %w[er third_masculin nominative he personal],
            %w[sie third_feminin nominative she personal],
            %w[wir first_plurial nominative we personal],
            %w[ihr second_plurial nominative you personal],
            %w[Sie third_plurial nominative they personal],
            ################# DATIVE ##############
            %w[mir first_singular dative me personal],
            %w[dir second_singular dative you personal],
            %w[ihm third_masculin dative him personal],
            %w[ihr third_feminin dative her personal],
            %w[uns first_plurial dative us personal],
            %w[euch second_plurial dative you personal],
            %w[ihnen third_plurial dative them personal],
            ################# POSSESSIVE ############
            ################### ACCUSATIVE ############
            ################ MASCULIN #############
            %w[meinen first_singular accusative my possessive masculin],
            %w[deinen second_singular accusative your possessive masculin],
            %w[seinen third_masculin accusative his possessive masculin],
            %w[ihren third_feminin accusative her possessive masculin],
            %w[unseren first_plurial accusative our possessive masculin],
            %w[euren second_plurial accusative your(plu.) possessive masculin],
            %w[ihren third_plurial accusative their possessive masculin],
            ################ NEUTRAL #############
            %w[mein first_singular accusative my possessive neutral],
            %w[dein second_singular accusative your possessive neutral],
            %w[sein third_masculin accusative his possessive neutral],
            %w[ihr third_feminin accusative her possessive neutral],
            %w[unser first_plurial accusative our possessive neutral],
            %w[euer second_plurial accusative your(plu.) possessive neutral],
            %w[ihr third_plurial accusative their possessive neutral],
            ################ FEMININ #############
            %w[meine first_singular accusative my possessive feminin],
            %w[deine second_singular accusative your possessive feminin],
            %w[seine third_masculin accusative his possessive feminin],
            %w[ihre third_feminin accusative her possessive feminin],
            %w[unsere first_plurial accusative our possessive feminin],
            %w[eure second_plurial accusative your(plu.) possessive feminin],
            %w[ihre third_plurial accusative their possessive feminin],
            ################ PLURIAL #############
            %w[meine first_singular accusative my possessive plurial],
            %w[deine second_singular accusative your possessive plurial],
            %w[seine third_masculin accusative his possessive plurial],
            %w[ihre third_plurial accusative her possessive plurial],
            %w[unsere first_plurial accusative our possessive plurial],
            %w[eure second_plurial accusative your(plu.) possessive plurial],
            %w[ihre third_plurial accusative their possessive plurial],
            ################### DATIVE ############
            ################ MASCULIN #############
            %w[meinem first_singular dative my possessive masculin],
            %w[deinem second_singular dative your possessive masculin],
            %w[seinem third_masculin dative his possessive masculin],
            %w[ihrem third_feminin dative her possessive masculin],
            %w[unserem first_plurial dative our possessive masculin],
            %w[eurem second_plurial dative your possessive(plu.) masculin],
            %w[ihrem third_plurial dative their possessive masculin],
            ################ NEUTRAL #############
            %w[meinem first_singular dative my possessive neutral],
            %w[deinem second_singular dative your possessive neutral],
            %w[seinem third_masculin dative his possessive neutral],
            %w[ihrem third_feminin dative her possessive neutral],
            %w[unserem first_plurial dative our possessive neutral],
            %w[eurem second_plurial dative your possessive(plu.) neutral],
            %w[ihrem third_plurial dative their possessive neutral],
            ################ FEMININ #############
            %w[meiner first_singular dative my possessive feminin],
            %w[deiner second_singular dative your possessive feminin],
            %w[seiner third_masculin dative his possessive feminin],
            %w[ihrer third_feminin dative her possessive feminin],
            %w[unserer first_plurial dative our possessive feminin],
            %w[eurer second_plurial dative your possessive(plu.) feminin],
            %w[ihrer third_plurial dative their possessive feminin],
            ################ PLURIAL #############
            %w[meinen first_singular dative my possessive plurial],
            %w[deinen second_singular dative your possessive plurial],
            %w[seinen third_masculin dative his possessive plurial],
            %w[ihren third_plurial dative her possessive plurial],
            %w[unseren first_plurial dative our possessive plurial],
            %w[euren second_plurial dative your possessive(plu.) plurial],
            %w[ihren third_plurial dative their possessive plurial],
  ]
pronoun_check_array = pronouns.map do |array|
    Pronoun.find_or_create_by!(
    value: array[0],
    person: array[1],
    g_case: array[2],
    english: array[3],
    kind: array[4],
    gender: array[5]
      )
end

puts 'The following nouns were deleted because they were neither found or created:'
p SeedCleaner.clean(pronoun_check_array, Pronoun)

puts 'Pronouns are seeded!'
