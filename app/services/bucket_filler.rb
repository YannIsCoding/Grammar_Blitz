class BucketFiller
  def initialize(trials)
    @trials = trials
  end

  def go
    trials_by_verbs = @trials.group_by(&:verb)
    trials_by_verbs.each do |verb, trials|
      @bucket = Bucket.find_or_create_by!(user: trials.first.user, verb: verb)
      if trials.any?(&:fail?)
        @bucket.zero!
      elsif @bucket.short?
        @bucket.long!
      else
        @bucket.short!
      end
    end
  end
end
