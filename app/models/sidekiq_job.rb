class SidekiqJob < ActiveRecord::Base
  belongs_to :user
  belongs_to :pdf
end
