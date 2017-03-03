class ItemSearchTerm
  attr_reader :where_clause, :where_args, :order

  def initialize(search_term)
    search_term = search_term.downcase
    @where_clause = ""
    @where_args = {}
    build_for_name_or_des_search(search_term)
  end

  def build_for_name_or_des_search(search_term)
    @where_clause << case_insensitive_search(:name)
    @where_args[:name] = starts_and_end_with(search_term)
    @where_clause << " OR #{case_insensitive_search(:description)}"
    @where_args[:description] = starts_and_end_with(search_term)
    @order = "name asc"
  end

  def starts_and_end_with(search_term)
    "%" + search_term + "%"
  end

  def case_insensitive_search(field_name)
    "lower(#{field_name}) like :#{field_name}"
  end

end
