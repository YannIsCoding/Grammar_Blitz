pp = [%w[ich first_singular nominative I personal],
      %w[du second_singular nominative you personal],
      %w[er third_masculin nominative he personal],
      %w[sie third_feminin nominative she personal],
      %w[wir first_plurial nominative we personal],
      %w[ihr second_plurial nominative you personal],
      %w[Sie third_plurial nominative they personal],
  ]
pp.each do |array|
  Pronoun.find_or_create_by!(
    value: array[0],
    person: array[1],
    g_case: array[2],
    english: array[3],
    kind: array[4]
      )
end


puts 'Pronouns are seeded!'
