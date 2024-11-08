import 'package:math_expressions/math_expressions.dart';

class CalculationsFunctions {
  String resolveExprBrackets(String expression) {
    bool isDigit(String char) => int.tryParse(char) != null;
    final buffer = StringBuffer();
    int openBrackets = 0;

    for (int i = 0; i < expression.length; i++) {
      final char = expression[i];

      // Add '*' for implicit multiplication before '('
      if (char == '(' && i > 0 && (isDigit(expression[i - 1]) || expression[i - 1] == ')')) {
        buffer.write('*');
      }

      if (char == '(') {
        openBrackets++;
      } else if (char == ')' && openBrackets > 0) {
        openBrackets--;
      } else if (isDigit(char) && i > 0 && expression[i - 1] == ')') {
        buffer.write('*');
      }

      // Append character
      buffer.write(char);
    }

    // Close any unmatched '('
    buffer.write(')' * openBrackets);

    return buffer.toString();
  }

  static String evaluateExpression(String expression) {
    // Replace × and ÷ with * and / for evaluation
    expression = expression.replaceAllMapped(
      RegExp(r'[\u00D7\u00F7]'),
      (match) => match.input.substring(match.start, match.end) == '\u00D7' ? '*' : '/',
    );

    // Resolve brackets if needed
    if (expression.contains(RegExp(r'[()]'))) {
      expression = CalculationsFunctions().resolveExprBrackets(expression);
    }

    try {
      // Parse and evaluate expression
      Parser parser = Parser(const ParserOptions(implicitMultiplication: true));
      Expression exp = parser.parse(expression);
      ContextModel contextModel = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, contextModel);

      // Format result based on precision
      return formatResult(result);
    } catch (error) {
      return " ";
    }
  }

  static String formatResult(double result) {
    const double scientificNotationThreshold = 1e15;

    // Convert to scientific notation if beyond threshold
    if (result.abs() >= scientificNotationThreshold || result.abs() < 1e-15 && result != 0) {
      return result.toStringAsExponential(10).replaceAll(RegExp(r'(\.0+|(?<=\.\d*?)0+)(?=e|$)'), '');
    } else if (result == result.truncateToDouble()) {
      return result.truncate().toString(); // Remove .0 for whole numbers
    } else {
      return result.toString().replaceAll(RegExp(r'(?<=\.\d*?)0+$'), ''); // Remove trailing zeros
    }
  }
}
