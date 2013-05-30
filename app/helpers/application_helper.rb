module ApplicationHelper
	def cache_key_for(models, count)
		if count != 0
  		"#{count}-#{models.map(&:updated_at).max.utc.to_s(:number)}"
  	else
  		"#{count}"
  	end
	end
end
