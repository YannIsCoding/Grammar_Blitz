pp = [%w[ich first_singular nominative I],
      %w[du second_singular nominative you],
      %w[er third_masculin nominative he],
      %w[sie third_feminin nominative she],
      %w[wir first_plurial nominative we],
      %w[ihr second_plurial nominative you],
      %w[Sie third_plurial nominative they],
  ]
pp.each do |array|
  PersonalPronoun.find_or_create_by!(
    value: array[0],
    person: array[1],
    g_case: array[2],
    english: array[3]
      )
end


puts 'Pronouns are seeded!'
