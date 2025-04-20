# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fines::Categories::DeactivateService do
  include_context 'list_categories_stuff'

  describe '#call' do
    context 'when category has no children' do
      it 'deactivates only the category' do
        service = described_class.new(user: user, category: category_fine_active)
        service.call
        expect(category_fine_active.reload.active).to eq(false)
      end
    end

    context 'when category has children and grandchildren' do
      before {
        category_fine_root
        category_fine_child
        category_fine_child_child
      }

      it 'deactivates the root category and all its descendants' do
        service = described_class.new(user: user, category: category_fine_root)
        service.call

        expect(category_fine_root.reload.active).to eq(false)
        expect(category_fine_child.reload.active).to eq(false)
        expect(category_fine_child_child.reload.active).to eq(false)
      end

      it 'deactivates the child category and all its descendants' do
        service = described_class.new(user: user, category: category_fine_child)
        service.call

        expect(category_fine_child.reload.active).to eq(false)
        expect(category_fine_child_child.reload.active).to eq(false)
      end
    end
  end
end
