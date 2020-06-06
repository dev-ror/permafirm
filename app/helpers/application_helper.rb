module ApplicationHelper

    def class_name
        controller.controller_name === 'sessions' || controller.controller_name === 'registrations' ? 'login' : 'nav-md' 
    end
    def is_admin_layout
        controller.controller_name === 'sessions' || controller.controller_name === 'registrations'
    end
end
