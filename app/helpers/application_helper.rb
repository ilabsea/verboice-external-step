module ApplicationHelper

	def controller_name
		names = params[:controller].split('/')
		return '' if names.last == 'home'
		return 'User List' if names.last == 'accounts'
		return 'Setting' if names.last == 'registrations'
		names.last
	end

	def action_name
		return '' if params[:action] == 'index'
		return 'new' if params[:action] == 'create'
		params[:action]
	end

end
