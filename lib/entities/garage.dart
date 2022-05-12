enum GarageState { full, reserved, vacant }

class Garage {
  late String name;
  late final String gID;
  late final Map<double, double> coordinates;
  final int hourlyRate;
  final int capacity;
  GarageState state = GarageState.vacant;

  Garage({
    required this.name,
    required this.coordinates,
    required this.gID,
    required this.hourlyRate,
    required this.capacity,
  });

  factory Garage.fromJson(Map<String, dynamic> json) => Garage(
      name: json['name']! as String,
      gID: json['gID']!,
      coordinates: json['coordinates'],
      hourlyRate: json['hourlyRate'],
      capacity: json['capacity']);

  Map<String, dynamic> toJson() => {
        "gID": gID,
        "name": name,
        "coordinates": coordinates,
        "hourlyRate": hourlyRate,
        "capacity": capacity
      };
}
