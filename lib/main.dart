// import 'package:flutter/material.dart';
// import 'route/route_constants.dart';
// import 'theme/app_theme.dart';
// import '../../route/router.dart' as router;
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Shop Template by The Flutter Way',
//       theme: AppTheme.lightTheme(context),
//       themeMode: ThemeMode.light,
//       onGenerateRoute: router.generateRoute,
//       initialRoute: onbordingScreenRoute,
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Fake Store')),
        body: FutureBuilder(
          future: apiService.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
              return Center(child: Text('No products found'));
            }

            List products = snapshot.data as List;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index]['title']),
                  subtitle: Text("\$${products[index]['price']}"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
