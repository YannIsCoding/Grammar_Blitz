require 'seed_cleaner'
articles = [
  %w[der masculin nominative true false the],
  %w[die feminin nominative true false the],
  %w[das neutral nominative true false the],
  %w[die plurial nominative true false the],
  %w[der masculin nominative true true the],
  %w[die feminin nominative true true the],
  %w[das neutral nominative true true the],
  %w[die plurial nominative true true the],
  %w[ein masculin nominative false false a/an],
  %w[eine feminin nominative false false a/an],
  %w[ein neutral nominative false false a/an],
  %w[kein masculin nominative false true a/an],
  %w[keine feminin nominative false true a/an],
  %w[kein neutral nominative false true a/an],
  #
  %w[den masculin accusative true false the],
  %w[das neutral accusative true false the],
  %w[die feminin accusative true false the],
  %w[die plurial accusative true false the],
  %w[den masculin accusative true true the],
  %w[das neutral accusative true true the],
  %w[die feminin accusative true true the],
  %w[die plurial accusative true true the],
  %w[einen masculin accusative false false a/an],
  %w[ein neutral accusative false false a/an],
  %w[eine feminin accusative false false a/an],
  %w[keinen masculin accusative false true a/an],
  %w[kein neutral accusative false true a/an],
  %w[keine feminin accusative false true a/an],
  #
  %w[dem masculin dative true false] << 'the',
  %w[dem neutral dative true false] << 'the',
  %w[der feminin dative true false] << 'the',
  %w[den plurial dative true false] << 'the',
  %w[dem masculin dative true true] << 'the',
  %w[dem neutral dative true true] << 'the',
  %w[der feminin dative true true] << 'the',
  %w[den plurial dative true true] << 'the',
  %w[einem masculin dative false false] << 'a/an',
  %w[einem neutral dative false false] << 'a/an',
  %w[einer feminin dative false false] << 'a/an',
  %w[keinem masculin dative false true] << 'a/an',
  %w[keinem neutral dative false true] << 'a/an',
  %w[keiner feminin dative false true] << 'a/an',
  ]

article_check_array = articles.map do |article|
  Article.find_or_create_by!(
    value: article[0],
    gender: article[1],
    g_case: article[2],
    definite: article[3] == 'true',
    negation: article[4] == 'true',
    english: article[5]
      )
end

puts 'The following nouns were deleted because they were neither found or created:'
p SeedCleaner.clean(article_check_array, Article)

puts 'Articles are seeded!'
