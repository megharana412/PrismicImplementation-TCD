module ApplicationHelper
    def link_resolver()
        @link_resolver ||= Prismic::LinkResolver.new(nil) {|link|
      
          # URL for the category type
          if link.type == "about"
            "/about/" + link.uid
      
          # Default case for all other types
          else
            "/"
          end
        }
      end
end
