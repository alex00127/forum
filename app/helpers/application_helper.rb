module ApplicationHelper

	def topics_filter(options)
		params.slice(:order, :category).merge(options)
	end

end
