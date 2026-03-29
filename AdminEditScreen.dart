// Class representing a lecturer with optional properties.
class Lecturer {
  // The database key for the lecturer.
  String? key;
  // Data about the lecturer stored in a separate LecturerData object.
  LecturerData? lecturerData;
  // Constructor to initialize a Lecturer object with a key and associated data.
  Lecturer(this.key, this.lecturerData);
}

// Class representing detailed data for a lecturer.
class LecturerData {
  // Path to the image of the lecturer.
  String? imagePath;
  // Name of the lecturer.
  String? name;
  // About information of the lecturer.
  String? about;
  // Years of experience of the lecturer.
  int? yearsOfExp;
  // Subject taught by the lecturer.
  String? subject;
  // Average star rating of the lecturer.
  double? starRating;

  // Constructor for initializing all properties of a LecturerData.
  LecturerData(
      this.imagePath,
      this.name,
      this.about,
      this.yearsOfExp,
      this.subject,
      this.starRating,
      );

  // Method to convert LecturerData properties to a Map for JSON serialization.
  Map<String, dynamic> toJson() {
    return {
      "image": imagePath,
      "lecname": name,
      "about": about,
      "years": yearsOfExp,
      "subject": subject,
      'rating': starRating,
    };
  }

  // Factory constructor to create a LecturerData object from JSON map.
  LecturerData.fromJson(Map<dynamic, dynamic> json) {
    imagePath = json["image"];
    name = json["lecname"];
    about = json["about"];
    yearsOfExp = checkInteger(json["years"]);
    subject = json["subject"];
    starRating = checkDouble(json['rating']);
  }

  // Helper method to safely parse double values from dynamic inputs.
  double? checkDouble(value) {
    if (value is String) {
      return double.tryParse(value);
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else {
      return null; // Return null if input is neither String, double, nor int.
    }
  }

  // Helper method to safely parse integer values from dynamic inputs.
  int? checkInteger(value) {
    if (value is String) {
      return int.tryParse(value);
    } else if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else {
      return null; // Return null if input is neither String, int, nor double.
    }
  }
}
