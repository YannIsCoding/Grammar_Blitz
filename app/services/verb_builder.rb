class VerbBuilder < SentenceBuilderService
  attr_reader :verb, :trials

  def initialize(preterit:, user:, trials:)
    @preterit = preterit
    @user =     user #TODO Remove user and replace with buckets direcly
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
    @verbs_prob ||= [@zeros.pluck(:verb_id).to_a * 40,
                     @shorts.pluck(:verb_id).to_a * 20,
                     @longs.pluck(:verb_id).to_a * 10].flatten
  end

  def verb_and_subject
    @verb =     fetch_verb
    @person =   Person.fetch(@verb.person)
    @subject =  Pronoun.find_by(person: @person, kind: 'personal', g_case: 'nominative')
  end

  private

  # The method below returns exercice element depending on the previous mistake
  # of the user. When a user first start it get the element he as least perform on.
  # Next when he has tried during the session, the element he got is randomly
  # selected between the element already show and the one where mistake have been made.
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
    (@zeros.sample || @shorts.sample || @longs.sample)&.verb || @verbs.sample
  end
end
