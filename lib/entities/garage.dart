enum GarageState { full, reserved, vacant }

class Garage {
  late String name;
  late final String gID;
  late final Map<double, double> coordinates;
  final int capacity;

  Garage({
    required this.name,
    required this.coordinates,
    required this.gID,
    required this.capacity,
  });

  factory Garage.fromJson(Map<String, dynamic> json) => Garage(
      name: json['name']! as String,
      gID: json['gID']!,
      coordinates: json['coordinates'],
      capacity: json['capacity']);

  Map<String, dynamic> toJson() => {
        "gID": gID,
        "name": name,
        "coordinates": coordinates,
        "capacity": capacity
      };
}
