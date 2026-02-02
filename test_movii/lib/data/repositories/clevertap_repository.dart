import 'package:clevertap_plugin/clevertap_plugin.dart';
import '../../domain/entities/user_profile.dart';

class CleverTapRepository {
  void createProfile(UserProfile user) {
    var profile = {
      'Name': user.name,
      'Identity': user.identity,
      'Email': user.email,
      'Phone': user.phone,
    };
    CleverTapPlugin.onUserLogin(profile);
    print("Perfil creado en CleverTap: $profile");
  }

  Future<void> updateBirthDate(DateTime date) async {
    try {
      var profile = {'dob': CleverTapPlugin.getCleverTapDate(date)};
      await CleverTapPlugin.profileSet(profile);
      print("DOB enviada correctamente: $date");
    } catch (e) {
      print("Error en updateBirthDate: $e");
    }
  }

  void recordHelloWorldEvent({
    required int expMovil,
    required int expFlutter,
    required int apps,
  }) {
    var eventData = {
      'experiencia_desarrollo_movil': expMovil,
      'experiencia_desarrollo_flutter': expFlutter,
      'cantidad_apps_publicadas': apps,
    };

    CleverTapPlugin.recordEvent("Hola_mundo", eventData);
    print("Evento 'Hola_mundo' enviado con: $eventData");
  }
}
