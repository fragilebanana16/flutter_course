import 'dart:ui';

class AppColors {
  /// white background
  static const Color primaryBackground = Color.fromARGB(255, 255, 255, 255);

  /// grey background
  static const Color primarySecondaryBackground =
      Color.fromARGB(255, 247, 247, 249);

  /// main widget color blue
  static const Color primaryElement = Color.fromARGB(255, 61, 61, 216);

  /// main text color black
  static const Color primaryText = Color.fromARGB(255, 0, 0, 0);
  // video background color
  static const Color primary_bg = Color.fromARGB(210, 32, 47, 62);

  /// main widget text color white
  static const Color primaryElementText = Color.fromARGB(255, 255, 255, 255);
  // main widget text color grey
  static const Color primarySecondaryElementText =
      Color.fromARGB(255, 102, 102, 102);
  // main widget third color grey
  static const Color primaryThirdElementText =
      Color.fromARGB(255, 170, 170, 170);

  static const Color primaryFourElementText =
      Color.fromARGB(255, 204, 204, 204);
  //state color
  static const Color primaryElementStatus = Color.fromARGB(255, 88, 174, 127);

  static const Color primaryElementBg = Color.fromARGB(255, 238, 121, 99);
}

class ChillifyColor {
  static const Color primaryBackground = Color.fromARGB(255, 231, 235, 241);

  static const Color primary = Color(0xFF4D6B9C);
  static const Color second = Color(0xFFCEE3EE);
  static const Color third = Color.fromARGB(255, 90, 172, 240);
  static const Color special = Color(0xffFFB1B2);
}

// music page colors
class TColor {
  static Color get primary => const Color(0xffC35BD1);
  static Color get focus => const Color(0xffD9519D);
  static Color get unfocused => const Color(0xff63666E);
  static Color get focusStart => const Color(0xffED8770);

  static Color get secondaryStart => primary;
  static Color get secondaryEnd => const Color(0xff657DDF);

  static Color get org => const Color(0xffE1914B);

  static Color get primaryText => const Color(0xffFFFFFF);
  static Color get primaryText80 => const Color(0xffFFFFFF).withOpacity(0.8);
  static Color get primaryText60 => const Color(0xffFFFFFF).withOpacity(0.6);
  static Color get primaryText35 => const Color(0xffFFFFFF).withOpacity(0.35);
  static Color get primaryText28 => const Color(0xffFFFFFF).withOpacity(0.28);
  static Color get secondaryText => const Color(0xff585A66);

  static List<Color> get primaryG => [focusStart, focus];
  static List<Color> get secondaryG => [secondaryStart, secondaryEnd];

  static Color get bg => const Color(0xff181B2C);
  static Color get darkGray => const Color(0xff383B49);
  static Color get lightGray => const Color(0xffD0D1D4);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
