class StatsArticleComment < ActiveRecord::Base

	attr_accessible :article_id,
		:day,
		:nb_com_tot,
		:nb_com_no_mod,
		:nb_com_neg,
		:nb_com_pos,
		:nb_com_neutr

	belongs_to :article

	scope :recent, order("day ASC")
	scope :for_article, lambda { |article_id|
		if article_id
			where(:article_id => article_id)
		else
			[]
		end
	}
	scope :for_day, lambda { |date|
		if date
			# where(:day => (date)..(date + 1.day))
			where(:day => date)
		else
			[]
		end
	}

	def createComment(comment)
		nameAttr = self.getNameAttr(comment.opinion)
		self[nameAttr] = self[nameAttr] + 1
		self.nb_com_tot = self.nb_com_tot + 1
		self.save!

	end
  # adjust counts when updating a comment
  def updateComment(comment)
  	nameAttr = self.getNameAttr(comment.opinion)
  	previousNameAttr = self.getNameAttr(comment.opinion_was)
		self[nameAttr] = self[nameAttr] + 1
		self[previousNameAttr] = self[previousNameAttr] - 1
		self.save!
  end

	# adjust counts when removing a comment
	def removeComment(comment)
		nameAttr = self.getNameAttr(comment.opinion)
		val = self[nameAttr]
		self.nb_com_tot = self.nb_com_tot - 1
		self[nameAttr] = val - 1 if (val > 0)
		self.save!

	end

	# get the attribute corresponding to the comment opinion and moderation state
	def getNameAttr(opinion)
		case opinion
			when "positive"
				attrib = "nb_com_pos"
			when "negative"
				attrib = "nb_com_neg"
			when "neutral"
				attrib = "nb_com_neutr"
			else
				attrib = "nb_com_no_mod"
		end
		return attrib
	end

	# return the stat object corresponding to an article and a day
	# this ensure that only one stat is created for a given article and day
	def self.getDayStat(article_id, date)
		stat = StatsArticleComment.for_article(article_id)
		.for_day(date)
		.first
		stat = StatsArticleComment.create!(:article_id => article_id,:day => date.to_date) if stat.nil?
		return stat
	end

end
