class CalculatorWidgetsData {

// inputAs denotes what the user sees, evalAs denotes the format MathExpressions supports
static List<Map<String, dynamic>> advancedPanelKeys = [
  {
    'name': "log",
    'inputAs': "log(",
    'evalAs': "log10"
  },
  {
    'name': "ln",
    'inputAs': "ln(",
    'evalAs': "ln"
  },
  {
    'name': "\u221A", // Square root symbol (√)
    'inputAs': "√(",
    'evalAs': "sqrt"
  },
  {
    'name': "x\u00B2", // Superscript 2 for x^2 (²)
    'inputAs': "^2",
    'evalAs': "^2"
  },
  {
    'name': "%",
    'inputAs': "%",
    'evalAs': "%"
  },
  {
    'name': "hyp",
    'onClick': (){}
  },
  {
    'name': "x\u02B8", // Superscript y for x^y (ʸ)
    'inputAs': "^",
    'evalAs': "^" // for exponentiation
  },
  {
    'name': "x\u207B\u00B9", // Superscript -1 for x^-1 (⁻¹)
    'inputAs': "^-1",
    'evalAs': "^-1"
  },
  {
    'name': "sin",
    'inputAs': "sin(",
    'evalAs': "sin"
  },
  {
    'name': "cos",
    'inputAs': "cos(",
    'evalAs': "cos"
  },
  {
    'name': "tan",
    'inputAs': "tan(",
    'evalAs': "tan"
  },
  {
    'name': "e\u02B8", // Superscript y for e^y (ʸ)
    'inputAs': "e^",
    'evalAs': "exp" // exp() function for e^y
  },
  {
    'name': "\u02B8\u221Ax", // y superscript root of x (ʸ√x)
    'inputAs': "ʸ√x",
    'evalAs': "root" // Assuming root(y, x) is supported
  },
  {
    'name': "10\u02B8", // Superscript y for 10^y (ʸ)
    'inputAs': "10^",
    'evalAs': "10^"
  },
  {
    'name': "fr",
    'inputAs': "1/",
    'evalAs': "1/" // Assuming this is meant to be used as a reciprocal
  },
  {
    'name': "x!",
    'inputAs': "!",
    'evalAs': "!" // Factorial
  },
  {
    'name': "\u03C0", // Pi symbol (π)
    'inputAs': "π",
    'evalAs': "pi" // Constant Pi
  },
  {
    'name': "log\u2093y", // Log base x of y with x in subscript (ₓ)
    'inputAs': "log(",
    'evalAs': "log" // This may need a dynamic approach if base changes
  },
  {
    'name': "asin",
    'inputAs': "asin(",
    'evalAs': "asin"
  },
  {
    'name': "acos",
    'inputAs': "acos(",
    'evalAs': "acos"
  },
  {
    'name': "atan",
    'inputAs': "atan(",
    'evalAs': "atan"
  },
];


  static List<Map<String, dynamic>> acSectionKeys = [
    {
      'name': "(",
    },
    {
      'name': ")",
    },
    {
      'name': "AC",
    },
    {
      'name': "DEL",
    },
  ];

  static List<Map<String, dynamic>> numbersKeys = [
    {
      'name': "7",
    },
    {
      'name': "8",
    },
    {
      'name': "9",
    },
    {
      'name': "4",
    },
    {
      'name': "5",
    },
    {
      'name': "6",
    },
    {
      'name': "1",
    },
    {
      'name': "2",
    },
    {
      'name': "3",
    },
    {
      'name': "Ans",
    },
    {
      'name': "0",
    },
    {
      'name': ".",
    },
  ];

  static List<Map<String, dynamic>> signsKeys = [
    {
      'name': "\u00F7",
      'inputAs': "/"
    }, // ÷
    {
      'name': "\u00D7",
      'inputAs': "*"
    }, // ×
    {
      'name': "\u002D",
    }, // -
    {
      'name': "\u002B",
    }, // +
  ];
}
