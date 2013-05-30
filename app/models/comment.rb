class Comment < ActiveRecord::Base
  attr_accessible :article_id,
  :content,
  :is_moderated,
  :opinion,
  :user_id

  belongs_to :article

  validates :content, :presence => true
  validates :article_id, :presence => true

	scope :moderated, where("is_moderated = ?", true)
	scope :recent, order("created_at DESC")
	scope :neutral, where("opinion = ?", "neutral" )
	scope :positive, where("opinion = ?", "positive" )
	scope :negative, where("opinion = ?", "negative" )
	scope :from_article, lambda { |article_id|
    if article_id
      where(:article_id => article_id)
    else
      []
    end
  }


  def self.search(article_id, from, to, status)
    comments = Comment.from_article(article_id).recent

    begin
      unless from.empty?
        from_date = DateTime.parse(from)
        comments = comments.where("created_at >= ?", from_date)
      end
    rescue
      puts "From date incorrect #{from.to_s}"
      raise "from date format incorrect #{from.to_s}"
    end
    begin
      unless to.empty?
        to_date = DateTime.parse(to)
        comments = comments.where("created_at <= ?", to_date)
      end
    rescue
      puts "To date incorrect #{to.to_s}"
      raise "to date format incorrect #{to.to_s}"
    end
    case status
      when "mod"
        comments = comments.where(:is_moderated => true)
      when "not_mod"
        comments = comments.where(:is_moderated => false)
      when "neg"
        comments = comments.where(:opinion => "negative")
      when "pos"
        comments = comments.where(:opinion => "positive")
      when "neutr"
        comments = comments.where(:opinion => "neutral")
    end

    return comments
  end

end
