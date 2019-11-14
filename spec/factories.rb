FactoryBot.define do

  factory :user do
    email { 'test@example.com' }
    password { 'f4k3p455w0rd' }
  end

  factory :structure do
    name { 's_v_do' }
  end

  factory :exercice do
    name { 'accusative with direct object' }
    description { 'Very interesting description of the exercice goes here' }
    structure
  end

  factory :personal_pronoun do
    value { 'ich' }
    person { 'first_singular' }
    g_case { 'nominative' }
    english { 'I' }
  end

  factory :article do
    value { 'den' }
    gender { 'masculin' }
    g_case { 'accusative' }
    english { 'the' }
    definite { true }
  end

  factory :noun do
    value { 'kellner' }
    gender { 'masculin' }
    english { 'waiter' }
    is_a { 'people' }
  end

  factory :verb do
    value { 'bin' }
    person { 'first_singular' }
    g_case { 'nominative' }
    preterit { 'sein' }
    english { 'am' }
    go_with { ['people'] }
  end

  factory :link, class: 'VerbNounLink' do
    verb_id { 1 }
    noun_id { 1 }
  end
end
