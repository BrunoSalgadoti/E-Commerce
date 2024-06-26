import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Class that facilitates automated updating of documents in Firestore.
class FirebaseAutomatedMapsUpdate<T> {
  final String collectionPath;
  final Map<String, dynamic> Function(T) toMap;

  FirebaseAutomatedMapsUpdate({
    required this.collectionPath,
    required this.toMap,
  });

  /// Updates documents in Firestore with data from an object [T].
  /// This method retrieves the current data from the Firestore document,
  /// checks the presence of missing properties and updates the Firestore document
  /// accordingly.
  /// [object] is the object to be updated in Firestore.
  /// ________________________________________________________________________
  /// Example of use:
  /// ```dart
  /// EX: Product product = Product(); <- Class instance T,
  /// FirebaseAutomatedMapsUpdate<ClassYouWannaUpdateTheMap is "T" EX: Product>(
  /// collectionPath: 'products' <- Firebase collection path,
  /// toMap: (T) => T.toMap() <- there must be a Map<String, dynamic> with the name toMap,
  /// ).updateDocument(product);
  /// ```
  ///
  /// Developed in partnership with ChatGPT (That the Systems Dev Analyst
  /// of the Company BRN Info_Dev affectionately calls her Lia).
  Future<void> updateDocument(T object) async {
    PerformanceMonitoring().startTrace('autoMapsUpdate', shouldStart: true);

    final Map<String, dynamic> objectMap = toMap(object);

    // Get a reference to the Firestore document
    final documentRef = FirebaseFirestore.instance.collection(collectionPath);

    // Get the current document data from Firestore
    final QuerySnapshot querySnapshot = await documentRef.get();

    /// Check for missing properties and update the Firestore document
    for (final QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      final Map<String, dynamic> currentData = docSnapshot.data() as Map<String, dynamic>;

      objectMap.forEach((key, value) {
        if (!currentData.containsKey(key)) {
          currentData[key] = value;
        }
      });

      // Update the Firestore document
      await docSnapshot.reference.set(currentData);
    }
    PerformanceMonitoring().stopTrace('autoMapsUpdate');
  }
}
