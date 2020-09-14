class VerbPractice < SentenceBuilderService
  attr_reader :verb, :trials

  def initialize(preterit:, user:, trials:)
    @preterit = preterit
    @user =     user
    @verbs =    Verb.where(preterit: @preterit)
    @buckets =  Bucket.where(user: @user, verb: @verbs)
    @trials =   trials

    @zeros = @buckets.zero
    @shorts = @buckets.short
    @longs = @buckets.long
  end

  def generate
    verb_and_subject
    @value = { value: "#{@subject} #{@verb}".capitalize,
               english: "#{@subject.english} #{@verb.english}".capitalize }
  end

  def verbs_prob
    @verbs_prob ||= [@zeros.pluck(:verb_id).to_a * 4,
                     @shorts.pluck(:verb_id).to_a * 2,
                     @longs.pluck(:verb_id)].flatten
  end

  def verb_and_subject
    @verb =     fetch_verb
    @person =   Person.fetch(@verb.person)
    @subject =  Pronoun.find_by(person: @person, kind: 'personal', g_case: 'nominative')
  end

  private

  def fetch_verb
    return lowest_element if @trials.blank?

    @trials.pluck(:verb_id).each do |verb_id|
      verbs_prob.delete_at(verbs_prob.index(verb_id))
    end

    Verb.find gimme_verb
  end

  def gimme_verb
    verbs_prob.sample || @verbs.sample.id
  end

  def lowest_element
    (@zeros.sample || @shorts.sample || @longs.sample || @verbs.sample).verb
  end
end
