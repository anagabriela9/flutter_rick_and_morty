import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';

class DetallePersonajeState {
  const DetallePersonajeState();
}

class DetallePersonajeInitial extends DetallePersonajeState {}

class DetallePersonajeLoading extends DetallePersonajeState {}

class DetallePersonajeLoaded extends DetallePersonajeState {
  final Character character;

  DetallePersonajeLoaded(this.character);
}

class DetallePersonajeError extends DetallePersonajeState {
  final String message;

  DetallePersonajeError(this.message);
}

class DetallePersonajeCubit extends Cubit<DetallePersonajeState> {
  DetallePersonajeCubit() : super(DetallePersonajeInitial());

  void loadCharacterDetail(Character character) {
    try {
      emit(DetallePersonajeLoading());
      emit(DetallePersonajeLoaded(character));
    } catch (e) {
      emit(DetallePersonajeError(e.toString()));
    }
  }
}
