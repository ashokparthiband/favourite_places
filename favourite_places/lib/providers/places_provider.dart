import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';

final placesProvider = NotifierProvider<PlacesNotifier, List<Place>>(() {
  return PlacesNotifier();
});

class PlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() {
    return [
      Place(
        id: '1',
        title: 'Eiffel Tower',
        description: 'Iconic iron lattice tower in Paris, France',
      ),
      Place(
        id: '2',
        title: 'Statue of Liberty',
        description: 'Colossal neoclassical sculpture in New York',
      ),
      Place(
        id: '3',
        title: 'Big Ben',
        description: 'Historic clock tower in London, England',
      ),
      Place(
        id: '4',
        title: 'Taj Mahal',
        description: 'White marble mausoleum in Agra, India',
      ),
      Place(
        id: '5',
        title: 'Christ the Redeemer',
        description: 'Statue overlooking Rio de Janeiro, Brazil',
      ),
    ];
  }

  void addPlace(Place place) {
    state = [...state, place];
  }

  void removePlace(String id) {
    state = state.where((place) => place.id != id).toList();
  }
}
