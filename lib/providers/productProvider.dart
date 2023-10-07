// import 'package:calculations/database.dart';
// import 'package:calculations/modles/products.dart';
// import 'package:calculations/modles/reciept.dart';
// import 'package:flutter/widgets.dart';

// class ProductProvider extends ChangeNotifier {
//   bool isSelected = false;
//   bool isFiltereds = false;
//   bool changeFuture = false;

//   double total = 0.0;
//   double totalWeight = 0.0;
//   List<Product> _products = [];

//   List<Product> get products {
//     return [..._products];
//   }

//   void addProduct(Product product) {
//     _products.add(product);

//     notifyListeners();
//   }

//   String calcPrice() {
//     var sum = 0.0;
//     _products.forEach((e) {
//       sum += e.price;
//     });
//     return sum.toStringAsFixed(1);
//   }

//   void changeFutures() {
//     changeFuture = !changeFuture;
//     notifyListeners();
//   }

//   String wieghtforall() {
//     var sum = 0.0;
//     _products.forEach((e) {
//       sum += e.weight;
//     });
//     return sum.toStringAsFixed(1);
//   }

//   void removeproduct(Product value) {
//     _products.remove(value);
//     notifyListeners();
//   }

//   List<int> selected = [];

//   void addProducttoselected(int id) {
//     if (selected.contains(id)) {
//       selected.remove(id);
//     } else {
//       selected.add(id);
//     }
//     notifyListeners();
//   }

//   void removeSelected(int id) {
//     selected.remove(id);
//   }

//   Map updatevalues({
//     Product productsUpdate,
//     double value,
//   }) {
//     var totalamount = (value * productsUpdate.price) / productsUpdate.weight;

//     total += totalamount;
//     totalWeight += value;

//     notifyListeners();
//     print({total: totalWeight});
//     return {total: totalWeight};
//   }

//   double generalWeight(double value) {
//     return value += value;
//   }

//   List<Recipt> reciepts = [];

//   void addReciept(Recipt recipt) {
//     reciepts.add(recipt);
//     notifyListeners();
//   }

//   Future<String> getPriceForAll() async {
//     var sum = 0.0;
//     var products = await SQLiteDbProvider.db.getAllProducts();
//     products.forEach((e) {
//       sum += e.price;
//     });
//     return sum.toStringAsFixed(1);
//   }

//   Future<String> getWeightForAll() async {
//     var sum = 0.0;
//     var products = await SQLiteDbProvider.db.getAllProducts();
//     products.forEach((e) {
//       sum += e.weight;
//     });
//     notifyListeners();
//     return sum.toStringAsFixed(1);
//   }

//   removeone(int id) {
//     SQLiteDbProvider.db.delete(id);
//     notifyListeners();
//   }

//   removeRes(Recipt recipt) {
//     SQLiteDbProvider.db.deleteRes(recipt);
//     notifyListeners();
//   }

//   Future<List<Product>> getJustChoosen({String letter}) async {
//     var choosenProducts = await SQLiteDbProvider.db.getAllProducts();

//     return choosenProducts.where((element) => element.specialLetter == letter);
//   }

//   changeStatus() {
//     isFiltereds = !isFiltereds;
//     notifyListeners();
//   }

//   Future<List<String>> getJustStrings() async {
//     var products = await SQLiteDbProvider.db.getAllProducts();
//     var strings = products.map((e) => e.specialLetter).toSet();
//     List specialC = strings.toList();
//     return specialC;
//   }

//   Future<List<Product>> getAllProducts({String text}) async {
//     List<Product> products =
//         await SQLiteDbProvider.db.getAllProducts(text: text);
//     return products;
//   }
// }
