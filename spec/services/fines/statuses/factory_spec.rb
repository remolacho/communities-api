# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fines::Statuses::Factory do
  include_context 'legal_status_fines_stuff'
  include_context 'warning_status_fines_stuff'

  describe '#call' do
    let(:factory) { described_class.new(user: user_admin, fine: fine) }

    context 'when fine is legal type' do
      before do
        allow(fine).to receive(:fine_legal?).and_return(true)
        allow(fine).to receive(:fine_warning?).and_return(false)
      end

      it 'returns legal facade service' do
        result = factory.call

        expect(result).to be_an_instance_of(Fines::Statuses::Legal::FacadeService)
        expect(result.user).to eq(user_admin)
        expect(result.fine).to eq(fine)
      end
    end

    context 'when fine is warning type' do
      before do
        allow(fine).to receive(:fine_legal?).and_return(false)
        allow(fine).to receive(:fine_warning?).and_return(true)
      end

      it 'returns warning facade service' do
        result = factory.call

        expect(result).to be_an_instance_of(Fines::Statuses::Warning::FacadeService)
        expect(result.user).to eq(user_admin)
        expect(result.fine).to eq(fine)
      end
    end

    context 'when fine type is not supported' do
      before do
        allow(fine).to receive(:fine_legal?).and_return(false)
        allow(fine).to receive(:fine_warning?).and_return(false)
      end

      it 'raises NotImplementedError' do
        expect { factory.call }.to raise_error(NotImplementedError)
      end
    end
  end
end
