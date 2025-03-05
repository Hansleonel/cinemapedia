import 'package:intl/intl.dart';

class HumanFormats {
  static String ratingMovie(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formatterNumber;
  }

  static String votesMovie(double number) {
    final formatterNumber = NumberFormat.compact(locale: 'en').format(number);

    // Redondear el número a un decimal
    final roundedNumber = double.parse(
      formatterNumber.replaceAll(RegExp(r'[^\d.]'), ''),
    ).toStringAsFixed(1);

    // Reemplazar el número redondeado en el formato compacto
    return formatterNumber.replaceAll(RegExp(r'\d+(\.\d+)?'), roundedNumber);
  }
}
