import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';
import 'package:flutter_rick_and_morty/domain/usecases/get_characters.dart';

class PersonajesState {
  const PersonajesState();
}

class PersonajesInitial extends PersonajesState {}

class PersonajesLoading extends PersonajesState {}

class PersonajesLoaded extends PersonajesState {
  final List<Character> characters;

  PersonajesLoaded(this.characters);
}

class PersonajesError extends PersonajesState {
  final String message;

  PersonajesError(this.message);
}

class PersonajesCubit extends Cubit<PersonajesState> {
  final GetCharacters getCharacters;

  PersonajesCubit(this.getCharacters) : super(PersonajesInitial());

  void fetchCharacters(String name) async {
    try {
      emit(PersonajesLoading());
      final characters = await getCharacters(name);
      emit(PersonajesLoaded(characters));
    } catch (e) {
      emit(PersonajesError(e.toString()));
    }
  }
}
