module Recommendation
  class Engine
    def initialize(users)
      @users = users
    end

    def recommendation_for(user)
      (@users - [user]).flat_map do |user2|
        user2.products - user.products if (user.similar_to user2) > 0.7
      end.compact
    end
  end
end
