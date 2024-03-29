FactoryBot.define do
  factory :bucket do
    user { nil }
    level { 0 }
    verb { nil }
  end

  factory :practice_session do
    association :user
    association :exercice

    # association :atomizable, factory: :verb
  end

  factory :trial do
    result { :wrong }
    association :user, strategy: :build
    association :practice_session
  end

  factory :user do
    email { 'test@example.com' }
    password { 'f4k3p455w0rd' }
    username { 'Alan' }

    trait :competitor do
      email { 'competitor@aol.com' }
      password { 'not_the_sharpest' }
      username { 'leo' }
    end
  end

  # factory :structure do
  #   name { 's_v_do' }

  #   trait :v_s_do do
  #     name { 'v_s_do' }
  #   end

  #   trait :s_v_do_dative do
  #     name { 's_v_do_dative' }
  #   end

  #   trait :s_v_prep_do do
  #     name { 's_v_prep_do' }
  #   end

  #   trait :s_v_io_do do
  #     name { 's_v_io_do' }
  #   end
  # end

  factory :exercice do
    name { 'accusative with direct object' }
    description { 'Very interesting description of the exercice goes here' }
    hide_index { [2] }
    structure { 'kaufen_present' }

    trait :question_accusative do
      name { 'question with accusative direct object' }
      description { 'question with accusative direct object' }
      association :structure, name: 'v_s_do'
    end

    trait :direct_object_dative do
      name { 'Direct object dative' }
      description { 'sentences with the direct object dative' }
      association :structure, name: 's_v_do_dative'
    end

    trait :accusative_preposition do
      name { 'Accusative preposition' }
      description { 'sentences with accusative preposition' }
      association :structure, name: 's_v_prep_do'
    end

    trait :direct_indirect do
      name { 'Accusative and Dative at the same time!' }
      description { 'direct indirect object' }
      association :structure, name: 's_v_io_do'
      hide_index { [2, 4] }
    end

    trait :edicted do
      name { 'Sentene with preposition mit!' }
      description { 'Sentene with preposition mit' }
      structure { 's_v_do_mit' }
      hide_index { [3] }
      edicted { true }
    end
  end

  factory :edict do
    value { 'Ich fahre mit dem Fahrrad' }
    english { 'I drive with the bike' }
    association :exercice
    hide_index { [3] }
  end

  factory :pronoun, aliases: [:personal_pronoun,] do
    value { 'sie' }
    person { 'third_feminin' }
    g_case { 'nominative' }
    english { 'she' }
    kind { 'personal' }

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

    trait :first_person_feminin_dative do
      value { 'meiner' }
      person { 'first_person' }
      g_case { 'dative' }
      english { 'my' }
      gender { 'feminin' }
      kind { 'possessive' }
    end

    trait :possessive_first_person_feminin_dative do
      value { 'meiner' }
      person { 'first_person' }
      g_case { 'dative' }
      english { 'my' }
      gender { 'feminin' }
      kind { 'possessive' }
    end

    trait :possessive_first_person_masculin_dative do
      value { 'meinem' }
      person { 'first_person' }
      g_case { 'dative' }
      english { 'my' }
      gender { 'masculin' }
      kind { 'possessive' }
    end

    trait :possessive_first_person_feminin_accusative do
      value { 'meine' }
      person { 'first_person' }
      g_case { 'accusative' }
      english { 'my' }
      gender { 'feminin' }
      kind { 'possessive' }
    end
    trait :possessive_first_person_masculin_accusative do
      value { 'meinen' }
      person { 'first_person' }
      g_case { 'accusative' }
      english { 'my' }
      gender { 'masculin' }
      kind { 'possessive' }
    end
  end

  factory :article do
    value { 'die' }
    gender { 'feminin' }
    g_case { 'accusative' }
    english { 'the' }
    definite { true }
    negation { false }

    trait :definite_feminin_accusative do
    end

    trait :definite_masculin_accusative do
      value { 'den' }
      gender { 'masculin' }
    end

    trait :definite_feminin_dative do
      value { 'der' }
      g_case { 'dative' }
      english { 'the' }
    end

    trait :definite_masculin_dative do
      value { 'dem' }
      gender { 'masculin' }
      g_case { 'dative' }
      english { 'the' }
    end
  end

  factory :noun do
    value { 'kiste' }
    gender { 'feminin' }
    english { 'box' }
    kind { 'object' }

    trait :feminin_object do
    end

    trait :masculin_idea do
      value { 'kommunismus' }
      gender { 'masculin' }
      english { 'communism' }
      kind { 'idea' }
    end

    trait :feminin_idea do
      value { 'philosophie' }
      gender { 'feminin' }
      english { 'philosophy' }
      kind { 'idea' }
    end

    trait :masculin_object do
      value { 'teppich' }
      gender { 'masculin' }
      english { 'carpet' }
      kind { 'object' }
    end

    trait :feminin_person do
      value { 'kellnerin' }
      gender { 'feminin' }
      english { 'waitress' }
      kind { 'people' }
    end

  end

  factory :verb do
    value { 'kaufe' }
    person { 'first_singular' }
    g_case { 'accusative' }
    preterit { 'kaufen' }
    english { 'buy' }
    go_with { ['object'] }

    trait :first_person_accusative_that_go_with_object do
    end

    trait :geben_first_singular do
      value { 'gebe' }
      preterit { 'geben' }
      g_case { 'accu_dati' }
      english { 'give' }
    end

    trait :third_plurial_accusative_that_go_with_object do
      value { 'kaufen' }
      person { 'third_plurial' }
    end

    trait :first_person_dative_that_go_with_people do
      value { 'folge' }
      g_case { 'dative' }
      preterit { 'folgen' }
      english { 'follow' }
      go_with { ['people'] }
    end

    trait :first_person_accusative_that_dont_go_with_object do
      value { 'höre' }
      preterit { 'hören' }
      english { 'hear' }
      go_with { ['people', 'vehicule', 'animal'] }
    end

    trait :first_person_sein do
      value { 'bin' }
      preterit { 'sein' }
      english { 'am' }
      go_with { ['people', 'vehicule', 'animal'] }
    end

  end

  factory :verb_noun_link do
    noun
    verb

    trait :for_io_do do
      association :noun
      association :verb, :geben_first_singular
    end

    trait :accusative_masculin do
      association :noun, :masculin_object
      association :verb
    end

    trait :dative_form do
      association :noun, :feminin_person
      association :verb, :first_person_dative_that_go_with_people
    end
  end

  factory :preposition do
    trait :accusative do
      value { 'gegen' }
      g_case { 'accusative' }
      english { 'against' }
      verbs { ['sein'] }
      kind_nouns { ['idea'] }
    end

    trait :dative do
      value { 'aus' }
      g_case { 'dative' }
      english { 'from' }
      verbs { ['sein'] }
      kind_nouns { ['place'] }
    end
  end
end
