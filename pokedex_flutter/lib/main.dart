import 'package:flutter/material.dart';
import 'package:pokedex_flutter/data/di/app_injector.dart';
import 'package:pokedex_flutter/presentation/pages/pokemon_list/ui/pokemon_list_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjectors();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      initialRoute: '/pokemon_list',
      routes: {
        '/pokemon_list': (context) => const PokemonListScreen(),
      },
    );
  }
}
