# rubocop:disable all

class Array
  # class Array
  def included_in?(array)
    array.to_set.superset?(to_set)
  end

  # devuelve un array con los elementos repetidos
  def repeated_elements
    arr = find_all { |e| count(e) > 1 }
    arr.uniq
  end

  # Busca la primera coincidencia la elimina y la retorna
  # array.detect!{ -> (x) {x == 5} }
  def detect!(&block)
    return 'No block given' unless block

    each_with_index do |result, i|
      lambda = yield
      next unless lambda.call(result)

      delete_at(i)
      return result
    end

    nil
  rescue StandardError
  end
end
