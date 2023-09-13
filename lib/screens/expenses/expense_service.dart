import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getExpenses() async {
  final QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('test').get();

  List<Map<String, dynamic>> expenses =
      snapshot.docs.map((DocumentSnapshot doc) {
    return {
      'name': doc['name'],
      'description': doc['description'],
      'amount': doc['amount'],
      'date': doc['date'],
    };
  }).toList();

  return expenses;
}

double calculateTotalExpenses(List<Map<String, dynamic>> expenses) {
  double totalExpenses = 0.0;
  for (var expense in expenses) {
    totalExpenses += expense['amount'];
  }
  return totalExpenses;
}
