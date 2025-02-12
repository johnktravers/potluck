require './lib/dish'
require 'active_support/inflector'

class Potluck
  attr_reader :date, :dishes

  def initialize(date)
    @date = date
    @dishes = []
  end

  def add_dish(dish)
    @dishes.push(dish)
  end

  def get_all_from_category(category)
    @dishes.find_all do |dish|
      dish.category == category
    end
  end

  def menu
    menu = {}

    # Iterate over the list of categories
    get_categories.each do |cat|

      # Make a pluralized version of category name
      plural_cat = cat.to_s.pluralize.to_sym

      # Add sorted list of dishes to category key in menu hash
      get_all_from_category(cat).each do |dish|

        # If the plural category already exists as a key in the hash, add dish name
        if menu[plural_cat].class == Array
          menu[plural_cat].push(dish.name)

        # Otherwise make a new array for that key and add the dish name
        else
          menu[plural_cat] = []
          menu[plural_cat].push(dish.name)
        end
      end
    end

    # Alphabetize arrays of dish names within hash
    menu.each do |category, array|
      menu[category].sort!
    end

    # Return menu hash
    menu
  end

  def ratio(category)
    num_dishes = {}

    # Create a hash with category as the key and number of dishes in that
    # category as the value
    get_categories.each do |cat|
      num_dishes[cat] = get_all_from_category(cat).length
    end

    # Calculate ratio of dishes in that category to total dishes
    num_dishes[category].to_f / num_dishes.values.sum * 100
  end

  def get_categories
    # Create an array of categories
    categories = @dishes.map do |dish|
      dish.category
    end

    # Return only unique categories
    categories.uniq
  end

end
