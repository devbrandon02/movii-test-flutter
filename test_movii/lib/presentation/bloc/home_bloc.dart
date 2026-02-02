import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_movii/presentation/bloc/home_Event.dart';
import 'home_state.dart';
import '../../data/repositories/clevertap_repository.dart';
import '../../domain/entities/user_profile.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CleverTapRepository repository;

  HomeBloc(this.repository) : super(HomeState()) {
    on<CreateProfileEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 1));
      repository.createProfile(
        UserProfile(
          name: "Brando Rodriguez Torres",
          identity: "1235046409",
          email: "developer@movii.test",
          phone: "3046792776",
        ),
      );
      emit(
        state.copyWith(isLoading: false, message: "Perfil enviado a CleverTap"),
      );
    });

    on<AddBirthDateEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        await repository.updateBirthDate("1999, 9, 2");
        emit(
          state.copyWith(
            isLoading: false,
            message: "Fecha de Nacimiento confirmada",
          ),
        );
      } catch (e) {
        print("Error al enviar fecha: $e");
        emit(state.copyWith(isLoading: false, message: "Error: $e"));
      }
    });

    on<SendEventEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 1));
      repository.recordHelloWorldEvent(expMovil: 4, expFlutter: 3, apps: 5);
      emit(
        state.copyWith(
          isLoading: false,
          message: "Evento 'Hola_mundo' enviado",
        ),
      );
    });

    on<AsyncProcessEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final result = await Future.delayed(const Duration(seconds: 7), () {
        return "Calculo completado: 5 * 10 = 50";
      });

      emit(state.copyWith(isLoading: false, message: result));
    });

    on<GenerateWordsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 1));
      final random = Random();
      int count = random.nextInt(400) + 1;
      List<String> words = List.generate(count, (i) => "Word ${i + 1}");
      emit(state.copyWith(isLoading: false, words: words));
    });
  }
}
