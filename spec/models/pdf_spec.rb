# require 'spec_helper'

# describe Pdf do
#   it { should belong_to(:user) }
#   it { should have_many(:sidekiq_jobs) }

#   describe "parents_array" do
#     it "should return an empty array with no parents" do
#       pdf = Fabricate(:pdf)
#       expect(pdf.parents_array).to eq([])
#     end

#     it "should return a single item in array with a single parents" do
#       pdf = Fabricate(:pdf)
#       parent = Fabricate(:Folder)
#       pdf.parents << parent
#       expect(pdf.parents_array).to eq([])
#     end
#   end
# end
