
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

  if check_array.length != VerbNounLink.all.length
    puts '################# WARNING ##########################'
    puts 'The verb_noun_links table contains a different number of entry then the check array!'
    puts "Table contains #{VerbNounLinks.length} entries"
    puts "check_array contains #{check_array.length} entries"
  end


  puts 'VerbNounLinks are seeded!'

end
