import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_project/widget/custom_circular_indicator.dart';
import 'Details.dart';

class HomePage extends StatelessWidget {
  final Stream<QuerySnapshot> _imageStream =
  FirebaseFirestore.instance.collection('wallpapers').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 10,right: 10),
          child: StreamBuilder<QuerySnapshot>(
            stream: _imageStream,
            builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: circularprogressIndicator());
              }
              if (!snapshot.hasData) {
                return Center(child: Text("No wallpapers found"));
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var document = snapshot.data!.docs[index];
                  Map<String, dynamic>? data =
                  document.data() as Map<String, dynamic>?;

                  if (data == null || !data.containsKey('image_url')) {
                    return SizedBox(); // Prevents app crash if data is missing
                  }



                  return Hero(
                    tag: data['image_url'],
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(data['image_url']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Details(data['image_url']),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}