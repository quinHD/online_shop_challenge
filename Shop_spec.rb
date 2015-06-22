require './Shop'

RSpec.describe "Shop" do

	it "returns 0 if there are no items scanned" do
		rules = [Rule.new(:ac, 5.00), Rule.new(:am, 3.11), Rule.new(:ca, 11.23)]

		co = set_checkout_elements rules
		expect(co.total).to eq(0)
	end

	it "returns the total cost of the shopping cart without deals and without disccounts" do
		rules = [Rule.new(:ac, 5.00), Rule.new(:am, 3.11), Rule.new(:ca, 11.23)]

		co = set_checkout_elements rules
		co.scan :am, :am, :ca, :ac, :ac, :ac, :ca
		expect(co.total).to eq(43.68)
	end

	it "returns the total cost of the shopping cart with deals but without disccounts" do
		deals = [MineralWaterDeal.new(:am)]
		rules = [Rule.new(:ac, 5.00), Rule.new(:am, 3.11), Rule.new(:ca, 11.23)]

		co = set_checkout_elements rules, deals
		co.scan :am, :am, :ca, :ac, :ac, :ac, :ca
		expect(co.total).to eq(40.57)
	end

	it "returns the total cost of the shopping cart without deals but with disccounts" do
		rules = [OilRule.new(:ac, 5.00), Rule.new(:am, 3.11), Rule.new(:ca, 11.23)]

		co = set_checkout_elements rules
		co.scan :am, :am, :ca, :ac, :ac, :ac, :ca
		expect(co.total).to eq(42.18)
	end

	it "returns the total cost of the shopping cart with deals and with disccounts" do
		rules = [OilRule.new(:ac, 5.00), Rule.new(:am, 3.11), Rule.new(:ca, 11.23)]
		deals = [MineralWaterDeal.new(:am)]

		co = set_checkout_elements rules, deals
		co.scan :am, :am, :ca, :ac, :ac, :ac, :ca
		expect(co.total).to eq(39.07)

		co = set_checkout_elements rules, deals
		co.scan :am, :ac, :am, :am, :ca
		expect(co.total).to eq(22.45)
		
		co = set_checkout_elements rules, deals
		co.scan :am, :ac, :am, :am, :ca
		expect(co.total).to eq(22.45)

		co = set_checkout_elements rules, deals
		co.scan :am, :am
		expect(co.total).to eq(3.11)
		
		co = set_checkout_elements rules, deals
		co.scan :ac, :ac, :am, :ac
		expect(co.total).to eq(16.61)
	end

	private
		def set_checkout_elements rules, deals= []
			shopping_cart = ShoppingCart.new deals
			pricing_rules = PricingRulesManager.new rules

			Checkout.new shopping_cart, pricing_rules		
		end

end