require 'spec_helper'

describe SidekiqJob do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :driveable }
end
