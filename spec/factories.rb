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
    value { 'teppich' }
    gender { 'masculin' }
    english { 'carpet' }
    kind { 'object' }
  end

  factory :verb do
    value { 'kaufe' }
    person { 'first_singular' }
    g_case { 'accusative' }
    preterit { 'kaufen' }
    english { 'buy' }
    go_with { ['object'] }
  end

  factory :verb_noun_link do
    verb
    noun
  end
end
