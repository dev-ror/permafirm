module ApplicationHelper

    def class_name
        if controller.controller_name === 'sessions' || controller.controller_name === 'registrations'
            return "login"
        end

        # case controller.controller_name # controller.controller_name is the variable we want to compare
        # when 'sessions', 'registrations'
        #     return "login"
        # when 2
        #   puts "it was 2"
        # else
        #   puts "it was something else"
        # end
    end
end
