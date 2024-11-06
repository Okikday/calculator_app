import 'dart:developer';
import 'package:math_expressions/math_expressions.dart';

class CalculationsFunctions {
  static String evaluateExpression(String expression) {
    log("Trying to calculate $expression");
    try {
      // Create a parser
      Parser parser = Parser();

      // Parse the expression
      Expression exp = parser.parse(expression);

      // Evaluate the expression
      ContextModel contextModel = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, contextModel);
      return result.toString();
    } catch (error) {
      return "null";
    }
  }
}
