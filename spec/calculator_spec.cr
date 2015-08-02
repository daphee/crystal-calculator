require "./spec_helper"

describe "Calculator" do
	describe "infix_to_postfix" do
		it "correctly converts 3+4*2/(1-5)^2^3 to postfix" do
			Calculator.infix_to_postfix("3       + 4 * 2 /  ( 1 - 5 ) ^ 2 ^ 3").should eq ["3", "4", "2", "*", "1", "5", "-", "2", "3", "^", "^", "/", "+"]
		end

		it "correctly evaluates 3+4*2/(1-5)^2^3" do
			Calculator.evaluate("3 + 4 * 2 / ( 1 - 5 ) ^ 2 ^ 3").should eq (3.0 + 8.0/65536.0)
		end

		it "correctly evaluates (3 - 1) ^ 3 + 5" do
			Calculator.evaluate("(3 - 1) ^ 3 + 5").should eq 13
		end
	end
end
