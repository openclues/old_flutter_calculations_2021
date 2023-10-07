// // FutureBuilder(
// //                 future: ingredients.getUserIngredients(),
// //                 builder:
// //                     (BuildContext context, AsyncSnapshot<List<Ing>> snapshots) {
// //                   return snapshots.hasData
// //                       ? Container(
// //                           child: Column(
// //                             children: [
// //                               Padding(
// //                                 padding: const EdgeInsets.symmetric(
// //                                     horizontal: 20.0),
// //                                 child: Container(
// //                                   color: Colors.transparent,
// //                                   width: double.infinity,
// //                                   child: ListView.builder(
// //                                     shrinkWrap: true,
// //                                     physics: NeverScrollableScrollPhysics(),
// //                                     itemCount: snapshots.data.length,
// //                                     itemBuilder:
// //                                         (BuildContext context, int index) {
// //                                       return Container(
// //                                         decoration: BoxDecoration(),
// //                                         child: Container(
// //                                           decoration: BoxDecoration(
// //                                               color: productsData.selected
// //                                                       .contains(snapshots
// //                                                           .data[index].id)
// //                                                   ? Colors.purple
// //                                                   : Colors.black54,
//                                           //     borderRadius:
//                                           //         BorderRadius.circular(20)),
//                                           // margin: EdgeInsets.only(top: 5),
// //                                           child: Card(
// //                                             child: Stack(
// //                                               children: [
// //                                                 GestureDetector(
// //                                                   // onLongPress: () {
// //                                                   //   productsData
// //                                                   //       .addProducttoselected(
// //                                                   //           snapshots
// //                                                   //               .data[index]
// //                                                   //               .id);
// //                                                   // },
// //                                                   child: ExpansionTileCard(
// //                                                       baseColor: Colors.black54,
// //                                                       expandedColor:
// //                                                           Colors.black54,
// //                                                       children: [
// //                                                         Divider(
// //                                                           thickness: 2.0,
// //                                                           height: 1.0,
// //                                                         ),
// //                                                         Column(
// //                                                           crossAxisAlignment:
// //                                                               CrossAxisAlignment
// //                                                                   .start,
// //                                                           children: <Widget>[
// //                                                             Padding(
// //                                                               padding:
// //                                                                   const EdgeInsets
// //                                                                       .all(8.0),
// //                                                               child: Row(
// //                                                                 children: <
// //                                                                     Widget>[
// //                                                                   Text(
// //                                                                       "Category : ",
// //                                                                       style: TextStyle(
// //                                                                           color:
// //                                                                               Colors.cyan)),
// //                                                                   Text(snapshots
// //                                                                       .data[
// //                                                                           index]
// //                                                                       .category)
// //                                                                 ],
// //                                                               ),
// //                                                             ),
// //                                                             Divider(
// //                                                               thickness: 2.0,
// //                                                               height: 1.0,
// //                                                             ),
// //                                                             Padding(
// //                                                               padding:
// //                                                                   const EdgeInsets
// //                                                                       .all(8.0),
// //                                                               child: Text(
// //                                                                   "Product Note : ",
// //                                                                   style: TextStyle(
// //                                                                       color: Colors
// //                                                                           .cyan)),
// //                                                             ),
// //                                                             Container(
// //                                                                 width: 200,
// //                                                                 margin: EdgeInsets
// //                                                                     .only(
// //                                                                         left:
// //                                                                             20,
// //                                                                         top: 15,
// //                                                                         bottom:
// //                                                                             20,
// //                                                                         right:
// //                                                                             10),
// //                                                                 child: snapshots
// //                                                                             .data[
// //                                                                                 index]
// //                                                                             .note !=
// //                                                                         null
// //                                                                     ? Text(snapshots
// //                                                                         .data[
// //                                                                             index]
// //                                                                         .note)
// //                                                                     : Text("")),
// //                                                           ],
// //                                                         )
// //                                                       ],
// //                                                       title: Text(
// //                                                           snapshots.data[index]
// //                                                               .title,
// //                                                           style: TextStyle(
// //                                                             color: Colors.cyan,
// //                                                           )),
// //                                                       subtitle: Row(
// //                                                         children: [
// //                                                           Text("price : " +
// //                                                               snapshots
// //                                                                   .data[index]
// //                                                                   .price
// //                                                                   .toString() +
// //                                                               " "),
// //                                                           Text(" || "),
// //                                                           Container(
// //                                                             child: Expanded(
// //                                                               child: Text(" Weight : " +
// //                                                                   snapshots
// //                                                                       .data[
// //                                                                           index]
// //                                                                       .weight
// //                                                                       .toString()),
// //                                                             ),
// //                                                           ),
// //                                                         ],
// //                                                       ),
// //                                                       trailing: Text("")),
// //                                                 ),
// //                                                 Positioned(
// //                                                   top: -10,
// //                                                   right: 0,
// //                                                   child: IconButton(
// //                                                       icon: Icon(Icons.edit,
// //                                                           color: Colors
// //                                                               .lightGreenAccent),
// //                                                       onPressed: () {
// //                                                         Navigator.of(context).push(
// //                                                             MaterialPageRoute(
// //                                                                 builder:
// //                                                                     (context) =>
// //                                                                         EditProduct(
// //                                                                           id: snapshots
// //                                                                               .data[index]
// //                                                                               .id,
// //                                                                           price: snapshots
// //                                                                               .data[index]
// //                                                                               .price,
// //                                                                           title: snapshots
// //                                                                               .data[index]
// //                                                                               .title,
// //                                                                           weight: snapshots
// //                                                                               .data[index]
// //                                                                               .weight,
// //                                                                           intTitle: snapshots
// //                                                                               .data[index]
// //                                                                               .title,
// //                                                                           initspecial: snapshots
// //                                                                               .data[index]
// //                                                                               .category,
// //                                                                           intprice: snapshots
// //                                                                               .data[index]
// //                                                                               .price,
// //                                                                           intweight: snapshots
// //                                                                               .data[index]
// //                                                                               .weight,
// //                                                                           initNote: snapshots
// //                                                                               .data[index]
// //                                                                               .note,
// //                                                                           note: snapshots
// //                                                                               .data[index]
// //                                                                               .note,
// //                                                                         )));
// //                                                       }),
// //                                                 ),
// //                                                 Positioned(
// //                                                   top: 30,
// //                                                   right: 0,
// //                                                   child: IconButton(
// //                                                     icon: Icon(
// //                                                       Icons.delete,
// //                                                       color: Colors.cyan,
// //                                                     ),
//                                                     onPressed: () {
//                                                       // ScaffoldMessenger.of(
//                                                       //         context)
//                                                       //     .showSnackBar(
//                                                       //         SnackBar(
//                                                       //   content: Text(
//                                                       //       "Do you want to remove"),
//                                                       //   action: SnackBarAction(
//                                                       //       label: "remove",
//                                                       //       onPressed: () {
//                                                       //         productsData
//                                                       //             .removeone(
//                                                       //                 snapshots
//                                                       //                     .data[
//                                                       //                         index]
//                                                       //                     .id);
//                                                       //         productsData
//                                                       //             .removeSelected(
//                                                       //                 snapshots
//                                                       //                     .data[
//                                                       //                         index]
//                                                       //                     .id);
//                                                             }),
//                                                       ));
// //                                                     },
// //                                                   ),
// //                                                 ),
// //                                               ],
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       );
// //                                     },
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         )
// //                       : Center(child: CircularProgressIndicator());
// //                 }),