require 'seed_cleaner'
after :nouns, :verbs do
  check_array = []
  Verb.all.each do |verb|
    Noun.all.each do |noun|
      if verb.go_with.include?(noun.kind)
        check_array << VerbNounLink.find_or_create_by!(
          verb: verb,
          noun: noun
          )
      end
    end
  end

p 'Verb_noun_links created'

  puts 'The following nouns were deleted because they were neither found or created:'
  p SeedCleaner.clean(check_array, VerbNounLink)

  puts 'VerbNounLinks are seeded!'

end
