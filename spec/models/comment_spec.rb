require 'spec_helper'

describe Comment do
	context "#fields" do
		it { should respond_to(:content) }
		it { should respond_to(:article_id) }
		it { should respond_to(:user_id) }
		it { should respond_to(:created_at) }
		it { should respond_to(:is_moderated) }
		it { should respond_to(:opinion) }
	end


	context "#associations" do
		it { should belong_to( :article) }
	end

	context "#validations" do
		it { should validate_presence_of(:content) }
		it { should validate_presence_of(:article_id) }
	end

	context "#scopes" do
		describe ".recent" do
			before(:each) do
			  @c1 = FactoryGirl.create(:comment, :created_at => DateTime.now.end_of_day)
				@c2 = FactoryGirl.create(:comment, :created_at => DateTime.now)
			end
		  it "orders by most recent first" do
		  	Comment.recent().all.should eq([@c1, @c2])
		  end
		end

		describe ".moderated" do
			before(:each) do
			  @c1 = FactoryGirl.create(:comment, :is_moderated => false)
				@c2 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "positive")
			end
		  it "gets only moderated comments" do
		  	Comment.moderated().all.should eq([@c2])
		  end
		end

		describe ".neutral" do
			before(:each) do
			  @c1 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "positive")
			  @c2 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "neutral")
			  @c3 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "negative")
			end
		  it "gets only neutral comments" do
		  	Comment.neutral().all.should eq([@c2])
		  end
		end

		describe ".positive" do
			before(:each) do
			  @c1 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "positive")
			  @c2 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "neutral")
			  @c3 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "negative")
			end
		  it "get only positive comments" do
		  	Comment.positive().all.should eq([@c1])
		  end
		end

		describe ".negative" do
			before(:each) do
			  @c1 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "positive")
			  @c2 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "neutral")
			  @c3 = FactoryGirl.create(:comment, :is_moderated => true, :opinion => "negative")
			end
		  it "get only negative comments" do
		  	Comment.negative().all.should eq([@c3])
		  end
		end

		describe ".from_article" do
			before(:each) do
			  @a1 = FactoryGirl.create(:article_with_comments, comments_count: 1)
			  @a2 = FactoryGirl.create(:article_with_comments, comments_count: 1)
			end
		  it "gets only comments from particular article" do
		  	Comment.from_article(@a1).all.should eq(@a1.comments.recent())
		  end
		  it "returns an empty array if no article passed" do
		  	Comment.from_article("").all.should eq([])
		  end
		end
	end

	context "#methods"  do
	  describe "self.search(article_id, from, to, status)" do
	  	before(:each) do
			  @a1 = FactoryGirl.create(:article_with_comments, comments_count: 1)
			  @a2 = FactoryGirl.create(:article_with_comments, comments_count: 1)

			  @c1 = FactoryGirl.create(:comment, :article_id => @a1.id, :is_moderated => true, :opinion => "positive", :created_at => DateTime.now - 1.days)
			  @c2 = FactoryGirl.create(:comment, :article_id => @a1.id, :is_moderated => true, :opinion => "neutral", :created_at => DateTime.now)
			  @c3 = FactoryGirl.create(:comment, :article_id => @a1.id, :is_moderated => true, :opinion => "negative", :created_at => DateTime.now + 1.days)
			  @c4 = FactoryGirl.create(:comment, :article_id => @a1.id, :is_moderated => false )
			end

	    it "returns comments from the article" do
	      Comment.search(@a1, "", "", "").all.should include(@c1, @c2, @c3, @c4 )
	    end

	    it "returns comments from the 'from' date if present" do

	    	Comment.search(@a1, Date.today.to_s, "", "").all.should eq([@c3, @c2])
	    end

	    it "raise an error if from date format is incorrect" do
				expect {Comment.search(@a1, "not a date", "", "")}.to raise_error
	    end

	    it "returns comments until the 'to' date if present" do
				Comment.search(@a1, "", Date.today.to_s, "").all.should_not include(@c3)
	    end

	    it "raise an error if to date format is incorrect" do
	    	expect {Comment.search(@a1, "", "not a date", "")}.to raise_error
	    end

	    it "returns moderated comments when status is 'mod'" do
				Comment.search(@a1, "", "", "mod").all.should_not include(@c4)
				Comment.search(@a1, "", "", "mod").all.should include(@c1, @c2, @c3)
	    end

	    it "returns unmoderated comments when status is 'not_mod'" do
	    	Comment.search(@a1, "", "", "not_mod").all.should include(@c4)
				Comment.search(@a1, "", "", "not_mod").all.should_not include(@c1, @c2, @c3)
	    end

	    it "returns positive comments when status is 'pos'" do
	    	Comment.search(@a1, "", "", "pos").all.should include(@c1)
				Comment.search(@a1, "", "", "pos").all.should_not include(@c4, @c2, @c3)
	    end

	    it "returns negative comments when status is 'neg'" do
	    	Comment.search(@a1, "", "", "neg").all.should include(@c3)
				Comment.search(@a1, "", "", "neg").all.should_not include(@c4, @c2, @c1)
	    end

	    it "returns neutral comments when status is 'neutr'" do
	    	Comment.search(@a1, "", "", "neutr").all.should include(@c2)
				Comment.search(@a1, "", "", "neutr").all.should_not include(@c4, @c1, @c3)
	    end

	  end
	end

end
