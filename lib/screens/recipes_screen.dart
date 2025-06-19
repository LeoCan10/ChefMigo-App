// lib/recipes_screen.dart o lib/screens/recipes_screen.dart
import 'package:flutter/material.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  static const Color kGreen = Color(0xFF6FCF97);
  static const Color kLightGreen = Color(0xFFCFF3E3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado que ocupa toda la pantalla.
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin:
                    Alignment
                        .bottomCenter, // Degradado desde abajo hacia arriba
                end: Alignment.topCenter,
                colors: [kGreen, Colors.white], // De verde a blanco
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Encabezado con logo y menú.
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/sinfondo.png', height: 60),
                      const Icon(Icons.menu, color: Colors.black, size: 30),
                    ],
                  ),
                ),
                // Barra de navegación con los botones.
                Container(
                  color: const Color.fromARGB(255, 107, 232, 148),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Botones de navegación.
                      _navButton(context, 'Buscar por ingrediente', '/home'),
                      _navButton(context, 'Favoritos', '/favorites'),
                      _navButton(context, 'Lista de compras', '/shopping'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Título de la sección de recetas recomendadas.
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recetas Recomendadas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _recipeCard(
                        context,
                        title: "Milanesas de Pollo al Horno",
                        imageUrl: "assets/images/milas.jpg",
                        time: "30 min",
                        tags: ["Pollo", "Horno"],
                      ),
                      _recipeCard(
                        context,
                        title: "Pastel de Papas",
                        imageUrl: "assets/images/milas.jpg",
                        time: "27 min",
                        tags: ["Papas", "Carne"],
                      ),
                      // Agregar más tarjetas de recetas.
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Floating Action Button para el chat.
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // TODO: Implementar funcionalidad de chat.
                print('Chat button pressed on Recipes Screen!');
              },
              backgroundColor: kGreen, // Usa la constante kGreen.
              child: const Icon(
                Icons.chat_bubble,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper para los botones de navegación.
  Widget _navButton(BuildContext context, String label, String route) {
    bool isActive = ModalRoute.of(context)?.settings.name == route;
    return ElevatedButton(
      onPressed: () {
        if (!isActive) {
          Navigator.pushNamed(context, route);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isActive ? kGreen : Colors.white, // Usa la constante kGreen.
        foregroundColor: isActive ? Colors.white : Colors.black,
        elevation: 1,
        shadowColor: Colors.black26,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  // Tarjeta de receta reutilizable, soporta imágenes de asset y de red.
  Widget _recipeCard(
    BuildContext context, {
    required String title,
    required String imageUrl,
    required String time,
    required List<String> tags,
  }) {
    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            '/details',
          ), // Navega a los detalles de la receta.
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            // Lógica para seleccionar entre Image.asset y Image.network.
            imageUrl.startsWith('assets/')
                ? ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                  child: Image.asset(
                    imageUrl,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
                : ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(time),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children:
                        tags
                            .map(
                              (t) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      kLightGreen, // Usa la constante kLightGreen.
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  t,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
