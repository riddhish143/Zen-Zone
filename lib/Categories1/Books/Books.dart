import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Modal/ProductModal/BookCategoryModel/GreatPersonality.dart';
import 'package:final2/Modal/ProductModal/BookCategoryModel/HealthView.dart';
import 'package:final2/Modal/ProductModal/BookCategoryModel/SelfHelpView.dart';
import 'package:final2/Modal/ProductModal/BookCategoryModel/YogaView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'BookList.dart';
import 'Books Descritption.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  State<Books> createState() => _BooksState();

}

class _BooksState extends State<Books> {
  List<BookList> books = [
    BookList(
        url: 'https://www.africau.edu/images/default/sample.pdf',
        id: DateTime.now().toString(),
        title: 'A123',
        author: 'Ashitosh Sable',
        cost: 299,
        description:
        'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. It is also used to temporarily replace text in a process called greeking, which allows designers to consider the form of a webpage or publication, without the meaning of the text influencing the design.',
        category: 'Self Help'),
    BookList(
        url: 'https://www.africau.edu/images/default/sample.pdf',
        id: DateTime.now().toString(),
        title: 'B123',
        author: 'Riddhish Mahajan',
        cost: 699,
        description:
        'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. It is also used to temporarily replace text in a process called greeking, which allows designers to consider the form of a webpage or publication, without the meaning of the text influencing the design.',
        category: 'Yoga'),
    BookList(
        url: 'https://www.africau.edu/images/default/sample.pdf',
        id: DateTime.now().toString(),
        title: 'C123',
        author: 'Sahil Kirti',
        cost: 644,
        description:
        'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. It is also used to temporarily replace text in a process called greeking, which allows designers to consider the form of a webpage or publication, without the meaning of the text influencing the design.',
        category: 'Health'),
    BookList(
        url: 'https://www.africau.edu/images/default/sample.pdf',
        id: DateTime.now().toString(),
        title: 'D123',
        author: 'Shivam Kumar',
        cost: 832,
        description:
        'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. It is also used to temporarily replace text in a process called greeking, which allows designers to consider the form of a webpage or publication, without the meaning of the text influencing the design.',
        category: 'Personality'),
    BookList(
        url: 'https://www.africau.edu/images/default/sample.pdf',
        id: DateTime.now().toString(),
        title: 'E123',
        author: 'Tanmay Mahajan',
        cost: 345,
        description:
        'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. It is also used to temporarily replace text in a process called greeking, which allows designers to consider the form of a webpage or publication, without the meaning of the text influencing the design.',
        category: 'Self Help'),
  ];

  void bookDes(BuildContext ctx, dynamic product) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: ctx,
      builder: (context) {
        return Stack(
          children: [
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                )),
            BookDecription(products: product)
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream =
    FirebaseFirestore.instance.collection('Book_detail').snapshots();

    final avlHeight = MediaQuery
        .of(context)
        .size
        .height;
    return StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
                  'This category \n has no Self Help Book items yet !',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.abyssinicaSil(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ));
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(20),
                      height: (avlHeight) * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage("images/Blur/behance4.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (ctx, constraints) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(),
                              Text(
                                " Find a best\nbook for you",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    fontFamily: "Ubuntu"),
                              ),
                              Container(
                                height: constraints.maxHeight * 0.4,
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.deepOrange[200],
                                ),
                                child: Center(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          "https://e7.pngegg.com/pngimages/406/551/png-clipart-book-and-cross-illustration-cross-and-bible-designed-logo-love-christianity-thumbnail.png"),
                                    ),
                                    title: Text(
                                      "Book Title",
                                      style: TextStyle(
                                          fontFamily: "Ubuntu",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    subtitle: Text("Continue reading"),
                                    trailing: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      )),
                  Container(
                    color: Colors.white,
                    height: avlHeight * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        "https://www.shutterstock.com/image-vector/vector-illustration-hands-hugging-heart-600w-1692037450.jpg"),
                                  ),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            BookViewScreen()));
                                  },
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "Self Help",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            YogaViewScreen()));
                                  },
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        "https://www.shutterstock.com/image-vector/vector-illustrator-benefits-meditation-healthy-600w-272533115.jpg"),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "Yoga",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            HealthViewScreen()));
                                  },
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        "https://www.shutterstock.com/image-vector/medical-health-care-flat-icons-600w-1597889392.jpg"),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "Health",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            GreatPersonalityViewScreen()));
                                  },
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        "https://www.shutterstock.com/image-vector/vector-illustration-famous-personalities-archimedes-600w-2229541961.jpg"),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "Great\nPersonalities",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    color: Colors.white,
                    height: avlHeight * 0.20,
                    child: Column(
                      children: [
                        Text(
                          "Most Popular",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  bookDes(context, books[index]);
                                },
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.38,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        'https://cdn.dribbble.com/users/2206903/screenshots/7217136/media/bebc640c62b02ad3a8982d82cc4a39f9.png?compress=1&resize=1200x900&vertical=top'))),
// child: Image.network(
//     'https://cdn.dribbble.com/users/2206903/screenshots/7217136/media/bebc640c62b02ad3a8982d82cc4a39f9.png?compress=1&resize=1200x900&vertical=top'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(books[index].title),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text("By ${books[index].author}")
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}