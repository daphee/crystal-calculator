# Crystal-Calculator
Small library to evaluate simple algebraic expressions like "3 + 4 * 2 / ( 1 - 5 ) ^ 2 ^ 3".
Converts them to RPN (Reverse Polish notation).

## Installation

Add it to `Projectfile`

```crystal
deps do
  github "daphee/crystal-calculator"
end
```

## Usage

```crystal
require "calculator"

# Evaluate an infix expression
Calculator.evaluate("(3 - 1) ^ 3 + 5") #=> 13.0

# Convert an infix expression to RPN 
Calculator.infix_to_postfix("(3 - 1) ^ 3 + 5") #=> ["3", "1", "-", "3", "^", "5", "+"]

# Evaluate an postfix epxression
Calculator.evaluate_postfix(["3", "1", "-", "3", "^", "5", "+"]) #=> 13.0
```

