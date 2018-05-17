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

  describe '#_get_dates' do
    let(:online) {}
    let(:local) {}

    context 'file can be access on internet' do
      let(:local) do
        [
          '2019-12-25',
          '2018-12-25',
          '2018-05-09',
          '2018-05-08'
        ]
      end
      let(:expected_result) do
        [
          '2019-12-25',
          '2018-12-25',
          '2018-05-09',
          '2018-05-08'
        ]
      end

      before do
        
      end

      it 'return expected array' do
        expect(described_class.get_dates()).to eq(expected_result)
      end
    end
  end

  describe '#_get_dates_from_web' do
    context 'file can be access on internet' do
      let(:expected_result) do
        [
          '2019-12-25',
          '2018-12-25',
          '2018-05-09',
          '2018-05-08'
        ]
      end

      it 'return expected array' do
        expect(described_class.get_dates_from_web()).to eq(expected_result)
      end
    end

    context 'failed to access file on internet' do
      let(:expected_result) do
        []
      end

      before do
        allow(YAML).to receive(:load).and_raise(OpenURI::HTTPError)
      end

      it 'return expected array' do
        expect(described_class.get_dates_from_web()).to eq(expected_result)
      end
    end
  end

  describe '#_get_dates_from_config' do
    context 'file if present on config folder' do
      let(:expected_result) do
        [
          '2119-12-25',
          '2015-12-25',
          '2118-05-09',
          '2016-05-08'
        ]
      end

      it 'return expected array' do
        expect(described_class.get_dates_from_config()).to eq(expected_result)
      end
    end

    context 'no file on config folder' do
      let(:expected_result) do
        []
      end

      before do
        allow(YAML).to receive(:load_file).and_raise(Errno::ENOENT)
      end

      it 'return expected array' do
        expect(described_class.get_dates_from_config()).to eq(expected_result)
      end
    end
  end
end
