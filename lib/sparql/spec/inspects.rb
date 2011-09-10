class Array
  alias_method :old_inspect, :inspect

  def inspect
    if all? { |item| item.is_a?(Hash) }
      string = "[\n"
      each do |item|
        string += "  {\n"
          item.keys.map(&:to_s).sort.each do |key|
            string += "      #{key}: #{item[key.to_sym].inspect}\n"
          end
        string += "  },\n"
      end
      string += "]"
      string
    elsif all? { |item| item.is_a?(RDF::Query::Solution)}
      string = "[\n"
      each do |item|
        string += "  {\n"
          item.bindings.keys.map(&:to_s).sort.each do |key|
            string += "      #{key}: #{item.bindings[key.to_sym].inspect}\n"
          end
        string += "  },\n"
      end
      string += "]"
      string
    else
      old_inspect
    end
  end
end

class RDF::Query::Solutions
  def inspect
    string = "vars: #{variable_names.join(",")}\n#{to_a.inspect}"
  end
end
