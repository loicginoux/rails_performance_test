require 'spec_helper'

describe StatsArticleComment do
	context "#fields" do
		it { should respond_to(:article_id) }
		it { should respond_to(:day) }
		it { should respond_to(:nb_com_tot) }
		it { should respond_to(:nb_com_no_mod) }
		it { should respond_to(:nb_com_neg) }
		it { should respond_to(:nb_com_pos) }
		it { should respond_to(:nb_com_neutr) }
	end


	context "#associations" do
		it { should belong_to( :article) }
	end

	context "#scopes" do
		pending "TODO"
	end

	context "#methods"  do
		pending "TODO"
	end

end
