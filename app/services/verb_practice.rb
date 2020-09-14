class VerbPractice < SentenceBuilderService
  attr_reader :verb

  def initialize(preterit:, user:, trials:)
    @preterit = preterit
    @user =     user
    @verbs =    Verb.where(preterit: @preterit)
    @buckets =  Bucket.where(user: @user, verb: @verbs)
    @verb =     fetch_verb
    @person =   Person.fetch(@verb.person)
    @subject =  Pronoun.find_by(person: @person, kind: 'personal', g_case: 'nominative')
    @trials = trials
  end

  def generate
    @value = { value: "#{@subject} #{@verb}".capitalize,
               english: "#{@subject.english} #{@verb.english}".capitalize }
  end

  private

  def fetch_verb
    @zeros = @buckets.zero
    @shorts = @buckets.short
    @longs = @buckets.long

    p 'HERE IS THE SHIT'
    p @trials


    # if @trials.present?
    #   grouped = @trials.group_by(:verb)
    # else
    #   if @zeros.present?
    #     return @zeros.sample.verb
    #   elsif @shorts.present?
    #     return @shorts.sample.verb
    #   else
    #     return @long.sample.verb
    #   end
    # end

    verbs_prob = [@zeros.pluck(:verb_id).to_a * 4, @shorts.pluck(:verb_id).to_a * 2, @longs.pluck(:verb_id)].flatten

    # @zeros.each do |zero|
    #   if grouped[zero.verb].count < coeficient * 4
    #     return zero.verb
    #   end
    # end

    # @shorts.each do |short|
    #   if grouped[short.verb].count < coeficient * 2
    #     return short.verb
    #   end
    # end

    # @longs.sample
    to_be_substracted = @trials&.pluck(:verb_id)

    to_be_substracted.each do |verb_id|
      verbs_prob.delete_at(verbs_prob.index(verb_id))
    end

    Verb.find verbs.prob.sample
  end

  # def coeficient
  #   unless coeff
  #     sum = @zeros.count * 4.0 + @shorts.count * 2 + @long.count
  #     coeff = 100 / sum
  #   end
  #   coeff
  # end


end
