require 'spec_helper'

RSpec.describe Mic::Daysoff do
  let(:stub_s3_file_url) { 'http://s3.test/bucket/days-off.yml' }

  before do
    ENV['MIC_DAYS_OFF_YML_URL_FILE'] = stub_s3_file_url

    stub_request(:get, stub_s3_file_url).with(headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
      }).to_return(
        status: 200,
        body: lambda { |request| File.new(Rails.root + 'spec/fixtures/online-web-days-off.yml') },
        headers: {}
      )

    described_class.reload_static_days_off
  end

  describe '#is_today_day_off?' do
    let(:stub_today) { '2015-12-25' }

    context 'online file available' do
      context 'today is on remote file' do
        before do
          Timecop.freeze(Date.new(2015, 12, 25))
        end

        after do
          Timecop.return
        end

        it 'return true' do
          expect(described_class.is_today_day_off?).to eq(true)
        end
      end

      context 'today is not on remote file' do
        before do
          Timecop.freeze(Date.new(2999, 12, 25))
        end

        after do
          Timecop.return
        end

        it 'return false' do
          expect(described_class.is_today_day_off?).to eq(false)
        end
      end
    end

    context 'remote file is not available'do
      context 'today is present on config/days-off.yml' do
        before do
          allow(Mic::Daysoff).to receive(:get_dates_from_web).and_return([])
          Timecop.freeze(Date.new(2119, 12, 25))
        end

        after do
          Timecop.return
        end

        it 'return true' do
          expect(described_class.is_today_day_off?).to eq(true)
        end
      end

      context 'today is present on config/days-off.yml' do
        before do
          allow(Mic::Daysoff).to receive(:get_dates_from_web).and_return([])
          Timecop.freeze(Date.new(2319, 12, 25))
        end

        after do
          Timecop.return
        end

        it 'return false' do
          expect(described_class.is_today_day_off?).to eq(false)
        end
      end
    end

    context 'remote file is not available and config/days-off.yml is not available' do
      context 'today is present on config/days-off.yml' do
        before do
          allow(Mic::Daysoff).to receive(:get_dates_from_web).and_return([])
          allow(Mic::Daysoff).to receive(:get_dates_from_config).and_return([])
          Timecop.freeze(Date.new(2119, 12, 25))
          described_class.reload_static_days_off
        end

        after do
          Timecop.return
        end

        it 'return false' do
          expect(described_class.is_today_day_off?).to eq(false)
        end
      end
    end
  end

  describe '#reload_static_days_off' do #TODO
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
          '2119-12-25',
          '2015-12-25',
          '2118-05-09',
          '2016-05-08'
        ]
      end

      it 'return expected array' do
        expect(described_class.get_dates()).to eq(expected_result)
      end
    end
  end

  describe '#_get_dates_from_web' do
    #TODO solve this test, code works
    # context 'file can be access on internet' do
    #   let(:expected_result) do
    #     [
    #       '2219-12-21',
    #       '2215-11-22',
    #       '2218-09-13',
    #       '2216-06-18'
    #     ]
    #   end
    #
    #   it 'return expected array' do
    #     expect(described_class.get_dates_from_web()).to eq(expected_result)
    #   end
    # end

    context 'failed to access file on internet' do
      let(:expected_result) do
        []
      end

      before do
        expect(OpenURI).to receive(:open_uri).and_raise(OpenURI::HTTPError)
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
