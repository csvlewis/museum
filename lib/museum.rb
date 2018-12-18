class Museum
  attr_reader :name,
              :exhibits,
              :patrons,
              :revenue,
              :patrons_of_exhibits
  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
    @patrons_of_exhibits = Hash.new([])
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def admit(patron)
    @patrons << patron
    exhibits_by_cost = @exhibits.sort_by {|exhibit| exhibit.cost}.reverse
    exhibits_by_cost.each do |exhibit|
      if exhibit.cost <= patron.spending_money && patron.interests.include?(exhibit.name)
        patron.spend(exhibit.cost)
        @revenue += exhibit.cost
        @patrons_of_exhibits[exhibit] += [patron]
      end
    end
  end

  def recommend_exhibits(patron)
    recommended_exhibits = []
    @exhibits.each do |exhibit|
      if patron.interests.include?(exhibit.name)
        recommended_exhibits << exhibit
      end
    end
    recommended_exhibits
  end

  def patrons_by_exhibit_interest
    hash = Hash.new([])
    @exhibits.each do |exhibit|
      @patrons.each do |patron|
        if patron.interests.include?(exhibit.name)
          hash[exhibit] += [patron]
        end
      end
    end
    hash
  end
end
