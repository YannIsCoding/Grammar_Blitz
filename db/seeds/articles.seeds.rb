
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
  Article.find_or_create_by!(
    value: article[0],
    gender: article[1],
    g_case: article[2],
    definite: article[3] == 'true',
    english: article[4]
      )
end

puts 'Articles are seeded!'
