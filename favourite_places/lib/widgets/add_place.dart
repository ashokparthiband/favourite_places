import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';
import '../providers/places_provider.dart';

class AddPlacePage extends ConsumerStatefulWidget {
  const AddPlacePage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends ConsumerState<AddPlacePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _savePlace() {
    if (_formKey.currentState!.validate()) {
      final newPlace = Place(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
      );

      ref.read(placesProvider.notifier).addPlace(newPlace);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Place added successfully!')),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place', style: textTheme.titleLarge),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Place Name',
                    labelStyle: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                    hintText: 'Enter place name',
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a place name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                    hintText: 'Enter place description',
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.description),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _savePlace,
                    child: Text(
                      'Save Place',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
