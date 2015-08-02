require "./calculator/*"

module Calculator
	Operators = {
		"^" => {4, :right_assoc, ->(a : Float64, b : Float64) { a ** b} },
		"*" => {3, :left_assoc,  ->(a : Float64, b : Float64) { a * b} },
		"/" => {3, :left_assoc,  ->(a : Float64, b : Float64) { a / b} },
		"+" => {2, :left_assoc,  ->(a : Float64, b : Float64) { a + b} },
		"-" => {2, :left_assoc,  ->(a : Float64, b : Float64) { a - b} }
	}

	def self.evaluate(expr : String)
		return evaluate_postfix(infix_to_postfix(expr))
	end

	# Convert infix to reverse polish notation using Shunting-yard algorithm
	def self.infix_to_postfix(expr : String)
		# Tokenize string

		tokens = [] of String
		currentToken = ""
		l = expr.length	
		expr.each_char_with_index do |char, index|
			if !char.digit? && currentToken != ""
				# Save buffered number
				tokens.push currentToken
				currentToken = ""
			end

			if char.digit?
				# Buffer single digits (except when end of string)
				if index < l - 1
					currentToken += char
				else 
					tokens.push "" + char 
				end

			elsif Operators[""+char]? || char == '(' || char == ')'
				# Simply copy Operators
				if Operators[""+char]? || char == '(' || char == ')'
					tokens.push "" + char 
				end
			end
		end

		# Simple translation of pseudocode on wikipedia but without function handling, only simple operations
		output = [] of String
		op_stack = [] of String

		tokens.each do |token|
			if token[0].digit?
				output.push token

			elsif Operators[token]?
				prec, assoc = Operators[token]
				while (!op_stack.empty? && Operators[op_stack.last?]? && ((assoc == :left_assoc && prec <= Operators[op_stack.last][0]) || prec < Operators[op_stack.last][0]))
					output.push op_stack.pop
				end	
				op_stack.push token

			elsif token == "("
				op_stack.push token

			elsif token == ")"
				begin
					until op_stack.last == "("
						output.push op_stack.pop
					end
					op_stack.pop #opening bracket
				rescue
					raise "Mismatched brackets"
				end
			end
		end

		until op_stack.empty? 
			op = op_stack.pop
			if op == "(" || op == ")"
				raise "Mismatched brackets"
			end
			output.push op 
		end

		return output
	end

	def self.evaluate_postfix(expr_stack : Array(String))
		stack = [] of Float64

		expr_stack.each do |token|
			if Operators[token]?
				a = stack.pop? || 0.0
				b = stack.pop? || 0.0
				stack.push(Operators[token][2].call(b,a))
			else
				stack.push(token.to_f)
			end
		end

		return stack.pop?
	end
end
