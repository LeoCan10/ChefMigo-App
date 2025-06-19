import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6FCF97), Colors.white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/sinfondo.png', height: 60),
                      const Icon(Icons.menu),
                    ],
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 107, 232, 148),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _navButton(context, 'Buscar por Ingredientes', '/home'),
                      _navButton(context, 'Favoritos', '/favorites'),
                      _navButton(context, 'Lista de compras', '/shopping'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Favoritos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _favoriteCard(
                        context,
                        title: 'Milanesas de Pollo al Horno',
                        imageUrl: 'https://via.placeholder.com/150',
                        tags: ['Pollo', 'Huevo', 'Horno'],
                      ),
                      _favoriteCard(
                        context,
                        title: 'Ñoquis de papa con salsa',
                        imageUrl: 'https://via.placeholder.com/150',
                        tags: ['Papa', 'Salsa', 'Queso'],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, String label, String route) {
    return ElevatedButton(
      onPressed: () {
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushNamed(context, route);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _favoriteCard(
    BuildContext context, {
    required String title,
    required String imageUrl,
    required List<String> tags,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/details');
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Wrap(
          spacing: 6,
          children:
              tags
                  .map(
                    (t) => Chip(
                      label: Text(t),
                      backgroundColor: const Color(0xFFE0F2F1),
                    ),
                  )
                  .toList(),
        ),
        trailing: const Icon(Icons.favorite, color: Colors.red),
      ),
    );
  }
}
