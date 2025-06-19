import 'package:flutter/material.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final List<Map<String, dynamic>> listasCreadas = [];
  static const Color kGreen = Color(0xFF6FCF97);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [kGreen, Colors.white],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header y navegación
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/sinfondo.png', height: 60),
                      const Icon(Icons.menu, color: Colors.black, size: 30),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: const Color.fromARGB(255, 107, 232, 148),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _navButton(context, 'Buscar por ingrediente', '/home'),
                        _navButton(context, 'Favoritos', '/favorites'),
                        _navButton(context, 'Lista de compras', '/shopping'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Título y botón
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lista de compras',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: _mostrarPopupNuevaLista,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Nueva lista"),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Listas predefinidas
                  Column(
                    children: [
                      _buildListContainer(
                        title: 'Compras Super',
                        items: [
                          ['Pan Lactal', 'Queso Untable'],
                          ['Harina', 'Crema de leche'],
                          ['Levadura', 'Leche líquida'],
                          ['Fideos', 'Salsa de tomate'],
                          ['Roquis', 'Carne'],
                          ['Queso Cremoso', 'Pollo sin piel'],
                          ['Queso rallado', 'Merluza'],
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildListContainer(
                        title: 'Verdulería',
                        items: [
                          ['Huevos', ''],
                          ['Manteca', ''],
                          ['Aceite', ''],
                          ['Nuggets', ''],
                        ],
                      ),
                    ],
                  ),

                  // Listas creadas por el usuario
                  const SizedBox(height: 20),
                  for (var lista in listasCreadas)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildUserListContainer(lista),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListContainer({
    required String title,
    required List<List<String>> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Column(
            children:
                items.map((itemPair) {
                  return Column(
                    children: [
                      if (itemPair[0].isNotEmpty) _buildListItem(itemPair[0]),
                      if (itemPair[1].isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: _buildListItem(itemPair[1]),
                        ),
                      const SizedBox(height: 8),
                    ],
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserListContainer(Map<String, dynamic> lista) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              lista['nombre'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children:
                  List<String>.from(lista['ingredientes'])
                      .map(
                        (item) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: kGreen.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: kGreen.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            item,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: kGreen, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _navButton(BuildContext context, String label, String route) {
    bool isActive = ModalRoute.of(context)?.settings.name == route;
    return ElevatedButton(
      onPressed: () {
        if (!isActive) {
          Navigator.pushNamed(context, route);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? kGreen : Colors.white,
        foregroundColor: isActive ? Colors.white : Colors.black,
        elevation: 1,
        shadowColor: Colors.black26,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  void _mostrarPopupNuevaLista() {
    String nombreLista = '';
    String nuevoIngrediente = '';
    List<String> ingredientesTemp = [];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('Nueva Lista'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la lista',
                    ),
                    onChanged: (value) => nombreLista = value,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Agregar ingrediente',
                    ),
                    onChanged: (value) => nuevoIngrediente = value,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreen,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (nuevoIngrediente.isNotEmpty) {
                        setModalState(() {
                          ingredientesTemp.add(nuevoIngrediente);
                          nuevoIngrediente = '';
                        });
                      }
                    },
                    child: const Text('Agregar Ingrediente'),
                  ),
                  Wrap(
                    spacing: 6,
                    children:
                        ingredientesTemp
                            .map(
                              (ing) => Chip(
                                label: Text(ing),
                                backgroundColor: kGreen.withOpacity(0.2),
                                onDeleted:
                                    () => setModalState(
                                      () => ingredientesTemp.remove(ing),
                                    ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGreen,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (nombreLista.isNotEmpty && ingredientesTemp.isNotEmpty) {
                      setState(() {
                        listasCreadas.add({
                          'nombre': nombreLista,
                          'ingredientes': List.from(ingredientesTemp),
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar Lista'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
