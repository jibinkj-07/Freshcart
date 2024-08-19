import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'comment.g.dart';

@HiveType(typeId: 4)
class Comment {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String comment;

  Comment({
    required this.id,
    required this.userId,
    required this.title,
    required this.comment,
  });

  factory Comment.fromFirebase(DataSnapshot comment) => Comment(
        id: comment.key.toString(),
        userId: comment.child("user_id").value.toString(),
        title: comment.child("title").value.toString(),
        comment: comment.child("comment").value.toString(),
      );

  Map<String, dynamic> toFirebaseJson() => {
        id: {
          "user_id": userId,
          "title": title,
          "comment": comment,
        }
      };
}
