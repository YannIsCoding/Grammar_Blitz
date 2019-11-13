FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { 'f4k3p455w0rd' }
  end

  factory :structure do
    name { 'structure_1' }
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
    value { 'der' }
    gender { 'masculin' }
    g_case { 'nominative' }
    english { 'the' }
  end

  factory :verb do
    value { 'bin' }
    person { 'first_singular' }
    g_case { 'nominative' }
    preterit { 'sein' }
    english { 'am' }
    go_with { 'people' }
  end
end
