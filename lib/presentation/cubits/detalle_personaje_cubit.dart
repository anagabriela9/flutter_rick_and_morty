import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/domain/entities/character.dart';
import 'package:flutter_rick_and_morty/presentation/cubits/detalle_personaje_state.dart';

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
