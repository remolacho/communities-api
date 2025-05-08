# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fines::Categories::ListService do
  include_context 'list_categories_stuff'

  let(:page) { 1 }
  let(:service) { described_class.new(user: user, page: page) }

  describe '#call' do
    context 'when there are active and inactive categories' do
      before do
        category_fine_root
        category_fine_child
        category_fine_child_child
        category_fine_inactive
      end

      it 'returns only active categories' do
        total_categories = CategoryFine.count
        result = service.hierarchy

        expect(result.count).to eq(total_categories - 1) # total minus inactive
        expect(result).not_to include(category_fine_inactive)
        expect(result).to include(category_fine_root)
      end
    end
  end
end
