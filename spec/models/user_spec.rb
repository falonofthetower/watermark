require 'spec_helper'

describe User do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { should have_many(:projects).through(:user_projects) }
end
