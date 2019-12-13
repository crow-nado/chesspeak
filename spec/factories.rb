FactoryBot.define do
  #Create user for testing authentication
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    sequence :username do |n|
      "user#{n}"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :game do
    name { "Test Name" }
    factory :sample_game do
      white_player_id { 1 }
      black_player_id { 2 }

      factory :sample_game_with_pieces do
        transient do
          pieces_count { 32 }
        end
      end
    end
  end

  factory :pawn do
    association :game, factory: :game

    factory :sample_white_pawn do
      color { "white" }
      x_position { 1 }
      y_position { 1 }
    end

    factory :sample_black_pawn do
      color { "black" }
      x_position { 1 }
      y_position { 7 }
    end
  end
end