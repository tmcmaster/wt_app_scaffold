import 'package:flutter/material.dart';
import 'package:wt_logging/wt_logging.dart';

class HomePage extends StatelessWidget {
  static final log = logger(HomePage);

  static const routeName = 'home';
  static const pageTitle = 'Home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pageTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Work in Progress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  static final log = logger(OrdersPage);

  static const routeName = 'orders';
  static const pageTitle = 'Orders';

  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pageTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Work in Progress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  static final log = logger(OrdersPage);

  static const routeName = 'products';
  static const pageTitle = 'Products';

  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pageTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Work in Progress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  static final log = logger(NotificationsPage);

  static const routeName = 'notifications';
  static const pageTitle = 'Notifications';

  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pageTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Work in Progress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
