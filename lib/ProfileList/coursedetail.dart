import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomerCourses extends StatefulWidget {
  const CustomerCourses({Key? key}) : super(key: key);

  @override
  State<CustomerCourses> createState() => _CustomerCoursesState();
}

class _CustomerCoursesState extends State<CustomerCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Subscribed Product",
          style: GoogleFonts.abyssinicaSil(
              fontWeight: FontWeight.w500, fontSize: 24, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            weight: 3,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('cid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went Wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 100, 60, 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .37,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/Blur/NoResult.jpg')),
                        border: Border.all(color: Colors.black, width: 2)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'No Subscribed Product',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var order = snapshot.data!.docs[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffadf9dd),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 3),
                              spreadRadius: 0.2,
                              color: Colors.black)
                        ],
                        border: Border.all(color: Colors.black, width: 1)),
                    child: ExpansionTile(
                      backgroundColor: Color(0xffadf9dd),
                      title: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            constraints:
                                BoxConstraints(maxHeight: 120, maxWidth: 120),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(order['orderImage'])),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .09,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: Center(
                                    child: Text(
                                      order['OrderName'],
                                      style: GoogleFonts.abyssinicaSil(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width / 3,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .03,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: Center(
                                    child: Text(
                                      (' ₹') + order['orderPrice'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.abyssinicaSil(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width / 3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      children: [
                        Container(
                          height: 140,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                NewWidget(
                                    title: 'Name', content: order['OrderName']),
                                NewWidget(
                                    title: 'Date',
                                    content: DateFormat('yyyy-MM-dd')
                                        .format(order['date'].toDate())
                                        .toString()),
                                NewWidget(
                                    title: 'Payment Method', content: order['delivery'])
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  final String title;
  final String content;

  NewWidget({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * .04,
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(colors: [
            Color(0xffaec2fa),
            Color(0xffb6e6c5),
          ]),
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                title,
                overflow: TextOverflow.fade,
                style: GoogleFonts.abyssinicaSil(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
            ),
            VerticalDivider(
              color: Colors.black,
              thickness: 1,
            ),
            Text(
              content,
              overflow: TextOverflow.fade,
              style: GoogleFonts.abyssinicaSil(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
