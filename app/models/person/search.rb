class Person::Search

  attr_accessor :term

  def self.with( term )
    s = Person::Search.new
    s.term = term
    s.search
  end

  def search
    Person.where("   ((first_name || ' ' || last_name) ILIKE :term) 
                  OR ((last_name || ' ' || first_name) ILIKE :term)
                  OR (business_name ILIKE :term)",
                  term: "%#{term}%").
           order('last_name')
  end

end

