import 'package:flutter/material.dart';
import 'package:multiple_screen_app/customer/customer_screen.dart';
import 'package:multiple_screen_app/kasir/kasir_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const KasirScreen());
    case 'customer':
      return MaterialPageRoute(builder: (_) => const CustomerScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}
