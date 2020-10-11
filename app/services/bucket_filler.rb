class BucketFiller
  def initialize(trials)
    @trials = trials
  end

  def go
    trials_by_atoms = @trials.group_by(&:atomizable)
    trials_by_atoms.each do |atom, trials|
      @bucket = Bucket.find_or_create_by!(user: trials.first.user, verb: atom)
      if trials.any?(&:wrong?)
        @bucket.zero!
      elsif @bucket.short?
        @bucket.long!
      else
        @bucket.short!
      end
    end
  end
end
