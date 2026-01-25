import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';

final placesProvider = NotifierProvider<PlacesNotifier, List<Place>>(() {
  return PlacesNotifier();
});

final favoritePlacesProvider =
    NotifierProvider<FavoritePlacesNotifier, Set<String>>(() {
      return FavoritePlacesNotifier();
    });

class PlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() {
    return [
      Place(
        title: 'Eiffel Tower',
        description: 'Iconic iron lattice tower in Paris, France',
      ),
      Place(
        title: 'Statue of Liberty',
        description: 'Colossal neoclassical sculpture in New York',
      ),
      Place(
        title: 'Big Ben',
        description: 'Historic clock tower in London, England',
      ),
      Place(
        title: 'Taj Mahal',
        description: 'White marble mausoleum in Agra, India',
      ),
      Place(
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

class FavoritePlacesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    return {};
  }

  void toggleFavorite(String placeId) {
    if (state.contains(placeId)) {
      state = {...state}..remove(placeId);
    } else {
      state = {...state, placeId};
    }
  }

  bool isFavorite(String placeId) {
    return state.contains(placeId);
  }
}
