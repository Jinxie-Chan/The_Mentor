import 'package:flutter/material.dart';
import '../data/DatabaseHelper.dart';
import '../data/LecturerModel.dart';

class AddLecturerScreen extends StatefulWidget {
  const AddLecturerScreen({super.key});

  @override
  _AddLecturerScreenState createState() => _AddLecturerScreenState();
}

class _AddLecturerScreenState extends State<AddLecturerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _yearsOfExperienceController = TextEditingController();
  final _aboutController = TextEditingController();
  final _imageNameController = TextEditingController(); // New controller for image name

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newLecturerData = LecturerData(
        _imageNameController.text, // Use the provided image name
        _nameController.text,
        _aboutController.text,
        int.tryParse(_yearsOfExperienceController.text) ?? 0,
        _subjectController.text,
        0.0, // Default star rating
      );

      final newLecturer = Lecturer(null, newLecturerData);

      // Save the new lecturer to the database
      DatabaseHelper.addLecturer(newLecturer).then((_) {
        Navigator.pop(context, true); // Return true to refresh the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 45, // Increase the size of the arrow
            color: Color.fromRGBO(25, 38, 93, 1), // Set the color
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _imageNameController, // Use the new controller for image name
                decoration: const InputDecoration(labelText: 'Image Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Lecturer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the lecturer name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearsOfExperienceController,
                decoration: const InputDecoration(labelText: 'Years of Experience'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the years of experience';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aboutController,
                decoration: const InputDecoration(labelText: 'About'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter about information';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(

                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(238, 155, 60, 1),
                  padding: const EdgeInsets.symmetric(
                      vertical: 13, horizontal: 20),
                ),
                child: const Text('Add Lecturer',
                  style: TextStyle(
                    fontSize: 23, // Increase the font size
                    fontWeight: FontWeight.bold, // Optional: make the text bold
                    color: Color.fromRGBO(25, 38, 93, 1), // Set the text color to rgb(25, 38, 93)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
