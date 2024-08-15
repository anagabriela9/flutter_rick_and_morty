# Rick and Morty Character App

Este proyecto es una aplicación móvil desarrollada en Flutter que permite a los usuarios ver una lista de personajes de la serie "Rick and Morty", buscar personajes por nombre y visualizar detalles de cada personaje. La aplicación utiliza la API de Rick and Morty para obtener los datos y sigue una arquitectura basada en BLoC/Cubit para la gestión del estado.

## Arquitectura del Proyecto

La aplicación sigue una arquitectura limpia (Clean Architecture) y está organizada en las siguientes capas:

- **Data**: Contiene las implementaciones para acceder a los datos, incluyendo los modelos y la fuente de datos remota que se comunica con la API.
- **Domain**: Define las entidades y los casos de uso (Use Cases) que encapsulan la lógica de negocio.
- **Presentation**: Contiene la UI y la gestión del estado utilizando Cubits y BLoC, además de las páginas de la aplicación.

### Estructura del Proyecto

```plaintext
lib/
│
├── data/
│   ├── datasources/
│   │   └── character_remote_datasource.dart
│   ├── models/
│   │   └── character_model.dart
│   └── repositories/
│       └── character_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   └── character.dart
│   ├── repositories/
│   │   └── character_repository.dart
│   └── usecases/
│       └── get_characters.dart
│
├── presentation/
│   ├── cubits/
│   │   ├── personajes_cubit.dart
│   │   └── detalle_personaje_cubit.dart
│   │   ├── detalle_personaje_state.dart
│   ├── pages/
│   │   ├── home_page.dart
│   │   └── character_detail_page.dart
│
└── main.dart


## Configuración en IDE de su preferencia


- **Instala las dependencias**: flutter pub get
- **Ejecutar**: flutter run
- **Testing**: flutter test
