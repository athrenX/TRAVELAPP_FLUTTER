import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/providers/auth_provider.dart';
import 'package:travelapp/providers/destinasi_provider.dart';
import 'package:travelapp/providers/kendaraan_provider.dart';
import 'package:travelapp/screens/admin/kelola_pembayaran_screen.dart';

import 'package:travelapp/screens/auth/login_screen.dart';
import 'package:travelapp/screens/auth/register_screen.dart';
import 'package:travelapp/screens/user/home_screen.dart';
import 'package:travelapp/screens/user/pembayaran_screen.dart';
import 'package:travelapp/screens/admin/dashboard_screen.dart';
import 'package:travelapp/screens/admin/kelola_pembayaran_screen.dart';
import 'package:travelapp/screens/user/wishlist_screen.dart';
import 'package:travelapp/providers/wishlist_provider.dart';
import 'package:travelapp/screens/user/pembayaran_screen.dart';

import 'package:travelapp/config/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DestinasiProvider()),
        ChangeNotifierProvider(create: (_) => KendaraanProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: MaterialApp(
        title: 'Travel App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppRoutes.home,
        routes: {
          // AppRoutes.login: (context) => LoginScreen(),
          // AppRoutes.register: (context) => RegisterScreen(),
          AppRoutes.home: (context) => HomeScreen(),
          AppRoutes.dashboard: (context) => DashboardScreen(),
          '/admin/pembayaran': (context) => KelolaPembayaranScreen(),
        },

        // Jika kamu butuh passing parameter ke screen:
        onGenerateRoute: (settings) {
          if (settings.name == '/user/pembayaran') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder:
                  (context) =>
                      PembayaranScreen(pemesananId: args['pemesananId']),
            );
          } else if (settings.name == '/user/wishlist') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => WishlistScreen(userId: args['userId']),
            );
          }
          return null;
        },
      ),
    );
  }
}
