class Checkout

  def initialize shopping_cart, pricing_rules_manager
    @shopping_cart = shopping_cart
    @pricing_rules_manager = pricing_rules_manager
  end

  def scan *items
    items.each do |item|
      @shopping_cart.increase_amount_of_item item
    end
  end

  def total
    @shopping_cart.apply_deals
    items = @shopping_cart.items

    shopping_cart_cost = items.reduce(0) do |result,(item, amount)|
      result + calculate_item_total_cost(item, amount)
    end

    format_price shopping_cart_cost
  end

  private

    def calculate_item_total_cost item, amount
      @pricing_rules_manager.get_item_price(item, amount) * amount
    end

    def format_price price
      "#{price}€"
    end
end

class ShoppingCart
  attr_accessor :items

  def initialize deals= []
    @items = Hash.new(0)
    @deals = deals
  end

  def increase_amount_of_item item
    @items[item] += 1
  end

  def apply_deals
    @deals.each do |deal|
      @items[deal.code] = deal.apply_deal @items[deal.code]
    end
  end
end

class PricingRulesManager
  def initialize rules
    @rules = rules
  end

  def get_item_price code, amount
    rule_found = @rules.find{|rule| rule.code == code}
    rule_found.get_price amount
  end
end


# RULES ########################################################################

class Rule
  attr_accessor :code, :price, :amount
  
  def initialize code, price
    @code = code
    @price = price
  end

  def get_price amount
    @price
  end
end

class OilRule < Rule
  def get_price amount
    amount >= 3 ? 4.5 : @price
  end
end


# DEALS ########################################################################

class MineralWaterDeal
  attr_accessor :code

  def initialize code
    @code = code
  end

  def apply_deal amount
    amount > 1 ? (amount/2.0).round : amount
  end
end
