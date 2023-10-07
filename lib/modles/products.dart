class Product{
  
final String title;
final double weight;
final double price;
final int id;
double newWeight;
final String note;
final String specialLetter;

  Product({this.title, this.weight, this.price, this.id, this.specialLetter, this.newWeight, this.note}); 

static final columns = ["id", "title", "weight" , "price" , "specialLetter", "newWeight", "note"];

factory Product.fromMap(Map<String, dynamic> data){

  return Product(
    id: data["id"], 
    price: data["price"],
    title: data["title"],
    weight: data["weight"], 
    specialLetter : data["specialLetter"],
    newWeight : data["newWeight"],
    note:data["note"]
  );

}

   Map toJson() => {
      "id": id, 
      "title": title, 
      "price": price, 
      "weight": weight ,
      "specialLetter" :specialLetter,
      "newWeight" : newWeight,
      "note" : note
   };


      Map<String, dynamic> toMap() => {
      "id": id, 
      "title": title, 
      "price": price, 
      "weight": weight ,
      "specialLetter" :specialLetter,
      "newWeight" : newWeight, 
      "note" : note
   }; 
 

}



