import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_movii/presentation/screen/home/home_presentation.dart';
import 'data/repositories/clevertap_repository.dart';
import 'presentation/bloc/home_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CleverTapPlugin.setDebugLevel(3);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: RepositoryProvider(
        create: (context) => CleverTapRepository(),
        child: BlocProvider(
          create: (context) => HomeBloc(context.read<CleverTapRepository>()),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
