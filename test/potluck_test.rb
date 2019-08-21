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
    @bean_dip = Dish.new("Bean Dip", :appetizer)

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

  def test_it_can_retrieve_dishes_in_a_category
    @potluck.add_dish(@couscous_salad)
    @potluck.add_dish(@summer_pizza)
    @potluck.add_dish(@roast_pork)
    @potluck.add_dish(@cocktail_meatballs)
    @potluck.add_dish(@candy_salad)

    assert_equal [@couscous_salad, @summer_pizza], @potluck.get_all_from_category(:appetizer)
    assert_equal [@roast_pork, @cocktail_meatballs], @potluck.get_all_from_category(:entre)
    assert_equal [@candy_salad], @potluck.get_all_from_category(:dessert)
  end

  def test_menu_creates_a_hash_of_dishes_by_category
    @potluck.add_dish(@couscous_salad)
    @potluck.add_dish(@summer_pizza)
    @potluck.add_dish(@roast_pork)
    @potluck.add_dish(@cocktail_meatballs)
    @potluck.add_dish(@candy_salad)
    @potluck.add_dish(@bean_dip)

    expected = {:appetizers => ["Bean Dip", "Couscous Salad", "Summer Pizza"],
                :entres => ["Cocktail Meatballs", "Roast Pork"],
                :desserts => ["Candy Salad"]
               }

    assert_equal expected, @potluck.menu
  end

  def test_ratio_of_dishes_by_category
    @potluck.add_dish(@couscous_salad)
    @potluck.add_dish(@summer_pizza)
    @potluck.add_dish(@roast_pork)
    @potluck.add_dish(@cocktail_meatballs)
    @potluck.add_dish(@candy_salad)
    @potluck.add_dish(@bean_dip)

    assert_equal 50.0, @potluck.ratio(:appetizer)
    assert_equal 33.33, @potluck.ratio(:entre).round(2)
    assert_equal 16.67, @potluck.ratio(:dessert).round(2)
  end

  def test_get_categories_returns_array_of_categories
    @potluck.add_dish(@couscous_salad)
    @potluck.add_dish(@summer_pizza)
    @potluck.add_dish(@roast_pork)
    @potluck.add_dish(@cocktail_meatballs)
    @potluck.add_dish(@candy_salad)
    @potluck.add_dish(@bean_dip)

    assert_equal [:appetizer, :entre, :dessert], @potluck.get_categories
  end

end
