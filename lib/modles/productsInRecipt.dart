
class ProductRes {
  final title;
  final price;
  final weight;

  ProductRes({this.title, this.weight, this.price});


    Map toJson()=>{
        "title" : title, 
        "price" : price, 
        "weight": weight,
    };



}