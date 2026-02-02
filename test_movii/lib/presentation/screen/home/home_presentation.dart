import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_movii/presentation/bloc/home_bloc.dart';
import 'package:test_movii/presentation/bloc/home_state.dart';
import '../../bloc/home_Event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movii Tech Test"),
        actions: [
          IconButton(icon: const Icon(Icons.info_outline), onPressed: () {}),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.message != null && !state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              OrientationBuilder(
                builder: (context, orientation) {
                  final isPortrait = orientation == Orientation.portrait;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 20),
                        if (isPortrait)
                          _buildPortraitLayout(context)
                        else
                          _buildLandscapeLayout(context),
                        const SizedBox(height: 20),
                        const Divider(),
                        _buildWordsSection(context, state.words),
                      ],
                    ),
                  );
                },
              ),

              if (state.isLoading)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Card(
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text(
                              "Procesando...",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Por favor espere 7 segundos"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(
              Icons.dashboard_customize_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              "Panel de Control",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Selecciona una opción para interactuar",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      children: [
        _menuButton(
          context,
          "Crear Perfil",
          Icons.person_add,
          CreateProfileEvent(),
          Colors.blue,
        ),
        _menuButton(
          context,
          "Añadir Nacimiento",
          Icons.cake,
          AddBirthDateEvent(),
          Colors.orange,
        ),
        _menuButton(
          context,
          "Enviar Evento",
          Icons.send,
          SendEventEvent(),
          Colors.green,
        ),
        _menuButton(
          context,
          "Proceso Asíncrono",
          Icons.timer,
          AsyncProcessEvent(),
          Colors.purple,
        ),
        _menuButton(
          context,
          "Generar Palabras",
          Icons.text_fields,
          GenerateWordsEvent(),
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.5,
      children: [
        _menuButton(
          context,
          "Crear Perfil",
          Icons.person_add,
          CreateProfileEvent(),
          Colors.blue,
        ),
        _menuButton(
          context,
          "Añadir Nacimiento",
          Icons.cake,
          AddBirthDateEvent(),
          Colors.orange,
        ),
        _menuButton(
          context,
          "Enviar Evento",
          Icons.send,
          SendEventEvent(),
          Colors.green,
        ),
        _menuButton(
          context,
          "Proceso Asíncrono",
          Icons.timer,
          AsyncProcessEvent(),
          Colors.purple,
        ),
        _menuButton(
          context,
          "Generar Palabras",
          Icons.text_fields,
          GenerateWordsEvent(),
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildWordsSection(BuildContext context, List<String> words) {
    if (words.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Palabras Generadas (${words.length}):",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Container(
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: words.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Chip(
                label: Text(
                  words[index],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _menuButton(
    BuildContext context,
    String text,
    IconData icon,
    HomeEvent event,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.centerLeft,
        ),
        onPressed: () => context.read<HomeBloc>().add(event),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
