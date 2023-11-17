import 'package:flutter_test/flutter_test.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

void main() {
  group('Restricted WebView', () {
    test('Starts With Predicate', () {
      final predicate = WebViewPredicates.startsWithPredicate(['abc']);
      expect(predicate('abc'), isTrue);
      expect(predicate('abcd'), isTrue);
      expect(predicate('abc d'), isTrue);
      expect(predicate(' abc'), isFalse);
      expect(predicate('ABC abc ABC'), isFalse);
    });
  });
  group('Ecwid Checkout', () {
    const baseCartUrl =
        'https://us-central1-ecompod-dd3e0.cloudfunctions.net/api/cart';

    test('Equals Cart', () {
      final predicate = WebViewPredicates.equalsPredicate(
        [baseCartUrl],
      );
      expect(predicate(baseCartUrl), isTrue);
      expect(predicate('$baseCartUrl?something'), isFalse);
      expect(predicate('$baseCartUrl#!/something'), isFalse);
    });
    test('Is Address, Delivery or Confirmation', () {
      final predicate = WebViewPredicates.startsWithPredicate([
        '$baseCartUrl#!/~/checkoutAddress',
        '$baseCartUrl#!/~/checkoutDelivery',
        '$baseCartUrl#!/~/orderConfirmation',
      ]);
      expect(predicate('$baseCartUrl#!/~/checkoutAddress'), isTrue);
      expect(predicate('$baseCartUrl#!/~/checkoutDelivery'), isTrue);
      expect(predicate('$baseCartUrl#!/~/orderConfirmation'), isTrue);
      expect(predicate('$baseCartUrl#!/~/checkoutAddress?aaa'), isTrue);
      expect(predicate('$baseCartUrl#!/~/checkoutDelivery?aaa'), isTrue);
      expect(predicate('$baseCartUrl#!/~/orderConfirmation?aaa'), isTrue);
      expect(predicate('$baseCartUrl#!/c/0'), isFalse);
    });
    test('Full Restriction Test', () {
      final predicate = WebViewPredicates.predicateList(
        [
          WebViewPredicates.equalsPredicate([
            baseCartUrl,
          ]),
          WebViewPredicates.startsWithPredicate([
            '$baseCartUrl#!/~/checkoutAddress',
            '$baseCartUrl#!/~/checkoutDelivery',
            '$baseCartUrl#!/~/orderConfirmation',
          ]),
        ],
      );
      expect(predicate('$baseCartUrl#!/~/checkoutAddress'), isTrue);
      expect(predicate('$baseCartUrl#!/~/checkoutDelivery'), isTrue);
      expect(predicate('$baseCartUrl#!/~/orderConfirmation'), isTrue);
      expect(predicate('$baseCartUrl#!/~/checkoutAddress?aaa'), isTrue);
      expect(predicate('$baseCartUrl#!/~/checkoutDelivery?aaa'), isTrue);
      expect(predicate('$baseCartUrl#!/~/orderConfirmation?aaa'), isTrue);
      expect(predicate('$baseCartUrl#!/c/0'), isFalse);
      expect(
        predicate('$baseCartUrl##!/1kg-Spelt-100/p/602575437/category=0'),
        isFalse,
      );
    });
  });
}
