class UtfCodes {
  static const UtfCodeTransform a = UtfCodeTransform('a');
  static const UtfCodeTransform b = UtfCodeTransform('b');
  static const UtfCodeTransform c = UtfCodeTransform('c');
  // Add more static constants as needed.
}

class UtfCodeTransform {
  final String character;

  const UtfCodeTransform(this.character);

  String get subscript {
    const subscriptMap = {
      // Numbers
      '0': '\u2080', // ₀
      '1': '\u2081', // ₁
      '2': '\u2082', // ₂
      '3': '\u2083', // ₃
      '4': '\u2084', // ₄
      '5': '\u2085', // ₅
      '6': '\u2086', // ₆
      '7': '\u2087', // ₇
      '8': '\u2088', // ₈
      '9': '\u2089', // ₉

      // Letters
      'a': '\u2090', // ₐ
      'e': '\u2091', // ₑ
      'h': '\u2095', // ₕ
      'i': '\u1D62', // ᵢ
      'j': '\u2C7C', // ⱼ
      'k': '\u2096', // ₖ
      'l': '\u2097', // ₗ
      'm': '\u2098', // ₘ
      'n': '\u2099', // ₙ
      'o': '\u2092', // ₒ
      'p': '\u209A', // ₚ
      'r': '\u1D63', // ᵣ
      's': '\u209B', // ₛ
      't': '\u209C', // ₜ
      'u': '\u1D64', // ᵤ
      'v': '\u1D65', // ᵥ
      'x': '\u2093', // ₓ

      // Letters y, z
      'y': '\u1D67', // ᵧ
      'z': '\u1DBB', // ᶻ (Closest to subscript form)

      // Parentheses and Symbols
      '(': '\u208D', // ₍
      ')': '\u208E', // ₎
    };

    return subscriptMap[character] ?? character; // Fallback to the original character if not found.
  }

  String get superscript {
    const superscriptMap = {
      // Numbers
      '0': '\u2070', // ⁰
      '1': '\u00B9', // ¹
      '2': '\u00B2', // ²
      '3': '\u00B3', // ³
      '4': '\u2074', // ⁴
      '5': '\u2075', // ⁵
      '6': '\u2076', // ⁶
      '7': '\u2077', // ⁷
      '8': '\u2078', // ⁸
      '9': '\u2079', // ⁹

      // Letters A-F
      'A': '\u1D2C', // ᴬ
      'B': '\u1D2E', // ᴮ
      // 'C': '\u1D2F', // ᶜ (Not superscript)
      'D': '\u1D30', // ᴰ
      'E': '\u1D31', // ᴱ
      // 'F': '\u1D32', // ᶠ (Not superscript)

      // Letters a-f
      'a': '\u1D43', // ᵃ
      'b': '\u1D47', // ᵇ
      // 'c': '\u1D48', // ᶜ (Not superscript)
      'd': '\u1D49', // ᵈ
      'e': '\u1D4B', // ᵉ
      // 'f': '\u1D4D', // ᶟ (Not superscript)

      // Letters x, y, z
      'x': '\u02E3', // ˣ
      'y': '\u02B8', // ʸ
      'z': '\u1DBB', // ᶻ

      // Special characters
      '+': '\u207A', // ⁺
      '-': '\u207B', // ⁻
      '=': '\u207C', // ⁼
      '(': '\u207D', // ⁽
      ')': '\u207E', // ⁾
    };

    return superscriptMap[character] ?? character; // Fallback to the original character if not found.
  }
}
