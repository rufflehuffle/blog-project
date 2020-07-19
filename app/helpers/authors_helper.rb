module AuthorsHelper
    def zero_authors_or_authenticated
        unless Author.count == 0 || current_user
          redirect_to root_path
          return false
        end
    end
end
