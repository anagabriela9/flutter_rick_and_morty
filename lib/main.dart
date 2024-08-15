import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rick_and_morty/data/datasources/character_remote_datasource.dart';
import 'package:flutter_rick_and_morty/data/repositories/character_repository_impl.dart';
import 'package:flutter_rick_and_morty/domain/usecases/get_characters.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/personajes_cubit.dart';
import 'package:flutter_rick_and_morty/presentation/pages/home_page.dart';


// TODO: Terminar estructura de la data ( datasources, repositories ) - domain/usecases
void main() {
  final Dio dio = Dio();
  final characterRemoteDataSource = CharacterRemoteDataSource(dio);
  final characterRepository = CharacterRepositoryImpl(characterRemoteDataSource);
  final getCharacters = GetCharacters(characterRepository);

  runApp(MyApp(getCharacters: getCharacters));
}

class MyApp extends StatelessWidget {
  final GetCharacters getCharacters;

  const MyApp({Key? key, required this.getCharacters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonajesCubit(getCharacters)..fetchCharacters(''),
      child: MaterialApp(
        title: 'Rick and Morty',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(color: Colors.grey[900]),
          textTheme: TextTheme(
            headlineSmall: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white70),
            bodyMedium: TextStyle(color: Colors.white54),
          ),
        ),
        themeMode: ThemeMode.system,  // Cambia entre oscuro y claro según la configuración del sistema
        home: HomePage(),
      ),
    );
  }
}
