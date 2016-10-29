require 'spec_helper'

describe UserProjects do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :project }
end
