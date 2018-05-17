require 'spec_helper'

RSpec.describe Mic::Daysoff do
  describe 'test rspec works' do
    it 'return true' do
      expect(true).to be true
    end
  end

  describe '#is_today_day_off?' do

  end

  describe '#reload_static_days_off' do

  end

  describe '#_get_dates_from_web' do

  end

  describe '#_get_dates_from_config' do
    context 'file if present on config' do
      let(:expected_result) do
        [
          '2119-12-25',
          '2015-12-25',
          '2118-05-09',
          '2016-05-08'
        ]
      end

      it 'return eepected array' do
        expect(described_class.get_dates_from_config()).to eq(expected_result)
      end
    end
  end
end
