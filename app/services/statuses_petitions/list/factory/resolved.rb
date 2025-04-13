# frozen_string_literal: true

module StatusesPetitions
  module List
    module Factory
      class Resolved < Base
        private

        # override
        def can_view?
          false
        end
      end
    end
  end
end
