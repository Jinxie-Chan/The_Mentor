import 'package:flutter/material.dart';
import '../data/LecturerModel.dart';
import '../screens/LecturerDetailScreen.dart';

class MyLecturerInfo extends StatelessWidget {
  final Lecturer? lecturer;
  final VoidCallback? onDelete;

  const MyLecturerInfo({super.key, required this.lecturer, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (lecturer != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LecturerDetailScreen(lecturer: lecturer!),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color.fromRGBO(238, 155, 60, 1),
              width: 3,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white12,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "images/${lecturer?.lecturerData?.imagePath}"),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Name: "),
                          Flexible(
                            child: Center(
                              child: Text(
                                lecturer!.lecturerData!.name.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(25, 38, 93, 1),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Subject: "),
                          Flexible(
                            child: Center(
                              child: Text(
                                lecturer!.lecturerData!.subject.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(25, 38, 93, 1),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (onDelete != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 6),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(25, 38, 93, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  _showDeleteConfirmationDialog(context);
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this lecturer?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                onDelete?.call(); // Trigger delete action
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
