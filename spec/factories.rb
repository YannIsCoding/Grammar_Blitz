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
    value { 'sie' }
    person { 'third_feminin' }
    g_case { 'nominative' }
    english { 'she' }

    trait :first_singular_nominative do
      value { 'ich' }
      person { 'first_singular' }
      english { 'I' }
    end

    trait :first_singular_accusative do
      value { 'mich' }
      person { 'first_singular' }
      g_case { 'accusative' }
      english { 'me' }
    end

    trait :third_feminin_nominative do
    end
  end

  factory :article do
    value { 'die' }
    gender { 'feminin' }
    g_case { 'accusative' }
    english { 'the' }
    definite { true }

    trait :definite_feminin_accusative do
    end

    trait :definite_masculin_accusative do
      value { 'den' }
      gender { 'masculin' }
    end

    trait :definite_feminin_dative do
      value { 'der' }
      g_case { 'dative' }
    end
  end

  factory :noun do
    value { 'kiste' }
    gender { 'feminin' }
    english { 'box' }
    kind { 'object' }

    trait :feminin_object do
    end

    trait :masculin_object do
      value { 'teppich' }
      gender { 'masculin' }
      english { 'carpet' }
      kind { 'object' }
    end
  end

  factory :verb do
    g_case { 'accusative' }
    preterit { 'kaufen' }
    english { 'buy' }
    go_with { ['object'] }
    person { 'first_singular' }
    value { 'kaufe' }

    trait :first_person_accusative_that_go_with_object do
    end

    trait :third_plurial_accusative_that_go_with_object do
      value { 'kaufen' }
      person { 'third_plurial' }
    end

    trait :first_person_dative_that_go_with_object do
      value { 'folge' }
      g_case { 'dative' }
      preterit { 'folgen' }
      english { 'follow' }
    end

    trait :first_person_accusative_that_dont_go_with_object do
      value { 'höre' }
      preterit { 'hören' }
      english { 'hear' }
      go_with { ['people', 'vehicule', 'animal'] }
    end
  end

  factory :verb_noun_link do
    noun
    verb
  end
end
