require 'spec_helper'

describe UserProject do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:project) }
end
