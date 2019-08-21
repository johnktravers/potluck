require 'minitest/autorun'
require 'minitest/pride'
require './lib/dish'
require './lib/potluck'

class PotluckTest < Minitest::Test

  def setup
    @couscous_salad = Dish.new("Couscous Salad", :appetizer)
    @summer_pizza = Dish.new("Summer Pizza", :appetizer)
    @roast_pork = Dish.new("Roast Pork", :entre)
    @cocktail_meatballs = Dish.new("Cocktail Meatballs", :entre)
    @candy_salad = Dish.new("Candy Salad", :dessert)

    @potluck = Potluck.new("7-13-18")
  end

  def test_it_exists
    assert_instance_of Potluck, @potluck
  end

  def test_it_has_a_date
    assert_equal '7-13-18', @potluck.date
  end

  def test_it_has_no_dishes_to_start
    assert_equal [], @potluck.dishes
  end

  def test_dishes_can_be_added
    @potluck.add_dish(@couscous_salad)

    assert_equal [@couscous_salad], @potluck.dishes
    assert_equal 1, @potluck.dishes.length

    @potluck.add_dish(@cocktail_meatballs)

    assert_equal [@couscous_salad, @cocktail_meatballs], @potluck.dishes
    assert_equal 2, @potluck.dishes.length
  end

  def test_added_dish_is_actually_a_dish
    assert_instance_of Dish, @couscous_salad
  end

end
