module ApplicationHelper

	def controller_name
		names = params[:controller].split('/')
		return '' if names.last == 'home'
		return 'Users' if names.last == 'accounts'
		return 'Setting' if names.last == 'registrations'
		names.last.camelize
	end

	def action_name
		return '' if params[:action] == 'index'
		return 'new' if params[:action] == 'create'
		params[:action]
	end

end
