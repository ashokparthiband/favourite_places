import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final String description;
  final File? image;

  Place({required this.title, required this.description, this.image})
    : id = uuid.v4();
}
