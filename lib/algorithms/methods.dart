import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:taskassistant/data/models/task.dart';
import 'package:taskassistant/data/models/user.dart';

class Methods {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final user = await FirebaseAuth.instance.signInWithCredential(credential);
    return user;
  }

  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'invalid-credential') {
        print('Invalid Credentials');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  String formatDate(DateTime date) {
    // Format month and day
    String month = DateFormat('MMMM').format(date); // e.g., March
    String day = date.day.toString(); // e.g., 1

    // Add suffix (st, nd, rd, th) to the day
    String suffix;
    if (day.endsWith('1') && day != '11') {
      suffix = 'st';
    } else if (day.endsWith('2') && day != '12') {
      suffix = 'nd';
    } else if (day.endsWith('3') && day != '13') {
      suffix = 'rd';
    } else {
      suffix = 'th';
    }

    // Combine parts into final format
    return "Today, $day$suffix $month";
  }

  Map<String, List<TaskModel>> bifurcateTasks(List<TaskModel> tasks) {
    DateTime now = DateTime.now();
    DateTime todayStart = DateTime(now.year, now.month, now.day);
    DateTime todayEnd = todayStart.add(const Duration(days: 1)).subtract(const Duration(seconds: 1));
    DateTime tomorrowStart = todayStart.add(const Duration(days: 1));
    DateTime tomorrowEnd = tomorrowStart.add(const Duration(days: 1)).subtract(const Duration(seconds: 1));
    DateTime weekStart = todayStart;
    DateTime weekEnd = todayStart.add(Duration(days: 7 - now.weekday));
    DateTime nextWeekStart = weekEnd.add(const Duration(days: 1));
    DateTime nextWeekEnd = nextWeekStart.add(const Duration(days: 7));

    Map<String, List<TaskModel>> categorizedTasks = {
      "Today": [],
      "Tomorrow": [],
      "This Week": [],
      "Next Week": [],
    };

    for (var task in tasks) {
      if (task.deadline.isAfter(todayStart) && task.deadline.isBefore(todayEnd)) {
        categorizedTasks["Today"]!.add(task);
      } else if (task.deadline.isAfter(tomorrowStart) && task.deadline.isBefore(tomorrowEnd)) {
        categorizedTasks["Tomorrow"]!.add(task);
      } else if (task.deadline.isAfter(weekStart) && task.deadline.isBefore(weekEnd)) {
        categorizedTasks["This Week"]!.add(task);
      } else if (task.deadline.isAfter(nextWeekStart) && task.deadline.isBefore(nextWeekEnd)) {
        categorizedTasks["Next Week"]!.add(task);
      } else {
        String range = DateFormat('EEE, MMM d').format(task.deadline);
        categorizedTasks.putIfAbsent(range, () => []).add(task);
      }
    }

    return categorizedTasks;
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users') // Replace 'users' with your collection name
          .where('email', isEqualTo: email)
          .get();
      // Check if any documents match the query
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email: $e');
      return false;
    }
  }

  Future<UserModel?> checkIfLoggedIn(User? currUser) async {
    try {
      if (currUser == null) {
        return null;
      } else {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where(
              'email',
              isEqualTo: currUser.email,
            )
            .get();
        return UserModel.fromJson(querySnapshot.docs.first.data());
      }
    } catch (e) {
      print('Error checking email: $e');
      return null;
    }
  }

  Future<UserModel?> fetchUserDataByEmail(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users') // Replace 'users' with your collection name
          .where('email', isEqualTo: email)
          .limit(1) // Optional: Limit to 1 result for efficiency
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Return the first document's data
        return UserModel.fromJson(querySnapshot.docs.first.data());
      } else {
        print('No user found with this email.');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
