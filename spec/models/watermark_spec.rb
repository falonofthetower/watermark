require 'spec_helper'

describe Watermark do
  it { is_expected.to have_many :sidekiq_jobs }
  it { is_expected.to belong_to :user }
end
