import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final String description;

  Place({required this.title, required this.description}) : id = uuid.v4();
}
