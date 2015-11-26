require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Redbooth do
  let(:app) do
    ->(_env) { [200, {}, ['Hello.']] }
  end

  let(:app_id) { '_app_id_' }
  let(:app_secret) { '_app_secret_' }
  let(:request) { double(params: {}, cookies: {}, env: {}) }
  let(:options) { Hash.new }

  let(:strategy) { described_class.new(app, app_id, app_secret, options) }

  before { allow(strategy).to receive(:request) { request } }

  around do |example|
    OmniAuth.config.test_mode = true
    example.run
    OmniAuth.config.test_mode = false
  end

  describe '#client' do
    let(:example_site) { 'https://example.com' }
    subject { strategy.client }

    context 'with the default config' do
      its(:site) { is_expected.to eq('https://redbooth.com/api/3') }

      describe 'the client options' do
        subject { strategy.client.options }

        its([:authorize_url]) do
          is_expected.to eq('https://redbooth.com/oauth2/authorize')
        end
        its([:token_url]) do
          is_expected.to eq('https://redbooth.com/oauth2/token')
        end
      end
    end

    context 'changing default :site' do
      let(:options) { { client_options: { site: example_site } } }

      its(:site) { is_expected.to eq(example_site) }
    end

    context 'changing default :authorize_url' do
      subject { strategy.client.options }
      let(:options) { { client_options: { authorize_url: example_site } } }

      its([:authorize_url]) { is_expected.to eq(example_site) }
    end

    context 'changing default :token_url' do
      subject { strategy.client.options }
      let(:options) { { client_options: { token_url: example_site } } }

      its([:token_url]) { is_expected.to eq(example_site) }
    end
  end

  describe ':authorize_params' do
    let(:options) do
      {
        authorize_params: {
          request_visible_actions: 'something',
          foo: 'bar',
          baz: 'zip'
        },
        bad: 'not_included'
      }
    end

    subject { strategy.authorize_params }

    its([:request_visible_actions]) { is_expected.to eq('something') }
    its([:foo]) { is_expected.to eq('bar') }
    its([:baz]) { is_expected.to eq('zip') }
    its([:bad]) { is_expected.to be_nil }
    its([:response_type]) { is_expected.to eq('code') }
    it { is_expected.to include(:state) }
  end

  describe ':token_params' do
    let(:options) do
      { token_params: { foo: 'bar', baz: 'zip' } }
    end

    subject { strategy.token_params }

    its([:foo]) { is_expected.to eq('bar') }
    its([:baz]) { is_expected.to eq('zip') }
  end

  describe ':token_options' do
    let(:options) do
      {
        token_options: [:scope, :foo],
        scope: 'bar',
        foo: 'baz',
        bad: 'not_included'
      }
    end

    subject { strategy.token_params }

    its([:scope]) { is_expected.to eq('bar') }
    its([:foo]) { is_expected.to eq('baz') }
    its([:bad]) { is_expected.to be_nil }
  end

  describe '#callback_path' do
    subject { strategy.callback_path }

    it { is_expected.to eq('/auth/redbooth/callback') }
  end
end
