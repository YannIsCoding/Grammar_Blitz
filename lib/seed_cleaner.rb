module SeedCleaner
  def self.clean(seeded_elements, class_name)
    class_name.all.select do |el|
      el.destroy unless seeded_elements.include?(el)
    end
  end
end
