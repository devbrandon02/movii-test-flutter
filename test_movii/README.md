# Movii Tech Test - Flutter App

Este proyecto es una aplicación de Flutter diseñada como parte de una prueba técnica para Movii. Implementa integraciones con **CleverTap** para el seguimiento de usuarios y eventos, siguiendo una arquitectura limpia con **BLoC** para la gestión del estado.

## 🚀 Tecnologías

- **Flutter**: ^3.10.7
- **State Management**: flutter_bloc ^9.1.1
- **Analytics/CRM**: clevertap_plugin ^3.6.0
- **Networking**: http ^1.6.0
- **Navegación**: Material Design 3

## 🏗️ Arquitectura

El proyecto sigue una estructura modular:
- **`lib/domain`**: Entidades y lógica de negocio.
- **`lib/data`**: Repositorios e implementaciones de fuentes de datos (CleverTap, APIs).
- **`lib/presentation`**: Capa de UI (Screens) y BLoCs.

## ✨ Funcionalidades

1. **Gestión de Perfil**: Creación de perfiles de usuario en CleverTap.
2. **Registro de Eventos**: Envío de eventos personalizados como `Hola_mundo` con propiedades dinámicas.
3. **Actualización de Fecha de Nacimiento**: Implementación robusta para el manejo de fechas (`dob`) en CleverTap.
4. **Procesos Asíncronos**: Manejo de estados de carga y respuestas asíncronas simuladas.
5. **Generación de Datos**: Listado dinámico de palabras generado aleatoriamente.

## 🛠️ Configuración y Ejecución

1. **Prerrequisitos**:
   - Flutter SDK instalado.
   - Un emulador de Android/iOS o dispositivo físico configurado.

2. **Instalación**:
   ```bash
   flutter pub get
   ```

3. **Ejecución**:
   ```bash
   flutter run
   ```

## 📝 Notas de Implementación (Fix Reciente)

Se corrigió un error persistente de `FormatException` en la actualización de la fecha de nacimiento. La solución incluyó:
- Tipificar el parámetro como `DateTime` en el repositorio para evitar errores de parseo de strings manuales.
- Uso de `CleverTapPlugin.getCleverTapDate()` para asegurar la compatibilidad con el SDK de CleverTap.

---

Desarrollado con ❤️ para Movii.
