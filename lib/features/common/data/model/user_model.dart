import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'address.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final DateTime createdOn;
  @HiveField(5)
  final List<int> favourites;
  @HiveField(6)
  final bool isAdmin;
  @HiveField(7)
  final List<Address> address;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.createdOn,
    required this.favourites,
    required this.isAdmin,
    required this.address,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? imageUrl,
    DateTime? createdOn,
    List<int>? favourites,
    bool? isAdmin,
    List<Address>? address,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        createdOn: createdOn ?? this.createdOn,
        favourites: favourites ?? this.favourites,
        isAdmin: isAdmin ?? this.isAdmin,
        address: address ?? this.address,
      );

  factory UserModel.fromFirebase(DataSnapshot userData, String uid) {
    final userInfo = userData.child("user_info");
    final favourites = userData.child("favourites").exists
        ? userData.child("favourites").value as List<dynamic>
        : [];
    List<Address> addresses = [];
    // Getting address details
    for (final address in userData.child("address").children) {
      addresses.add(Address.fromFirebase(address));
    }

    return UserModel(
      uid: uid,
      name: userInfo.child("name").value.toString(),
      email: userInfo.child("email").value.toString(),
      imageUrl: userInfo.child("image_url").value.toString(),
      createdOn: DateTime.fromMillisecondsSinceEpoch(
        int.parse(userInfo.child("created_on").value.toString()),
      ),
      favourites: favourites.map((e) => int.parse(e.toString())).toList(),
      isAdmin: userInfo.child("is_admin").value.toString() == "true",
      address: addresses,
    );
  }

  Map<String, dynamic> toFirebaseJson() => {
        "user_info": {
          "name": name,
          "email": email,
          "is_admin": isAdmin,
          "image_url": imageUrl,
          "created_on": createdOn.millisecondsSinceEpoch,
        },
        "favourites": favourites,
        "address": address.map((e) => e.toFirebaseJson()).toList(),
      };
}
