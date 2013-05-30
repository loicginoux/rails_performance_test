require 'spec_helper'

describe Article do
	context "#fields" do
		it { should respond_to(:content) }
		it { should respond_to(:title) }
		it { should respond_to(:user_id) }
	end


	context "#associations" do
		it { should have_many( :comments ).dependent(:destroy) }
	end


	context "#scopes" do
		describe ".recent" do
			before(:each) do
			  @a1 = FactoryGirl.create(:article, :created_at => DateTime.now.end_of_day)
			  @a2 = FactoryGirl.create(:article, :created_at => DateTime.now)
			end
		  it "orders by most recent first" do
		  	Article.recent().all.should eq([@a2, @a1])
		  end
		end
	end



end
