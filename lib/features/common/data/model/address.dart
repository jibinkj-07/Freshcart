import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'address.g.dart';

@HiveType(typeId: 2)
class Address {
  @HiveField(0)
  final String street;

  @HiveField(1)
  final String city;

  @HiveField(2)
  final String state;

  @HiveField(3)
  final String postalCode;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final String country;

  @HiveField(6)
  final String landmark;
  @HiveField(7)
  final String label;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.phone,
    required this.country,
    required this.landmark,
    required this.label,
  });

  factory Address.fromFirebase(DataSnapshot addressData) {
    return Address(
      street: addressData.child("street").value.toString(),
      city: addressData.child("city").value.toString(),
      state: addressData.child("state").value.toString(),
      postalCode: addressData.child("postal_code").value.toString(),
      phone: addressData.child("phone").value.toString(),
      country: addressData.child("country").value.toString(),
      landmark: addressData.child("landmark").value.toString(),
      label: addressData.key.toString(),
    );
  }

  Map<String, dynamic> toFirebaseJson() => {
        label: {
          "street": street,
          "city": city,
          "state": state,
          "postal_code": postalCode,
          "phone": phone,
          "country": country,
          "landmark": landmark,
        }
      };
}
