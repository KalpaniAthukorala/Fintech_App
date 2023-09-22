import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getIncomes() async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('incomes')
      .get(); // Update the collection name to 'incomes'

  List<Map<String, dynamic>> incomes =
      snapshot.docs.map((DocumentSnapshot doc) {
    return {
      'name': doc['name'],
      'description': doc['description'],
      'amount': doc['amount'],
      'date': doc['date'],
    };
  }).toList();

  return incomes;
}

double calculateTotalIncomes(List<Map<String, dynamic>> incomes) {
  double totalIncomes = 0.0;
  for (var income in incomes) {
    totalIncomes += income['amount'];
  }
  return totalIncomes;
}
