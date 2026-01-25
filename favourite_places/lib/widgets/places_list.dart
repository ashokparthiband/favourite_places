import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/places_provider.dart';
import '../models/place.dart';
import 'add_place.dart';
import 'place_details.dart';

class PlacesListPage extends ConsumerWidget {
  const PlacesListPage({Key? key}) : super(key: key);

  void _addPlace(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const AddPlacePage()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Great Places'),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addPlace(context),
            tooltip: 'Add Place',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return PlaceCard(place: place);
        },
      ),
    );
  }
}

class PlaceCard extends ConsumerWidget {
  final Place place;

  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(place.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        ref.read(placesProvider.notifier).removePlace(place.id);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${place.title} deleted')));
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailsPage(place: place),
              ),
            );
          },
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.place),
          ),
          title: Text(place.title),
          subtitle: Text(place.description),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
