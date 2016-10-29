require 'spec_helper'

describe Project do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_one(:user).through(:user_project) }
end
