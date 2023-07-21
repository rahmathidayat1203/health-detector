import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryUser extends StatefulWidget {
  const HistoryUser({Key? key}) : super(key: key);

  @override
  State<HistoryUser> createState() => _HistoryUserState();
}

class _HistoryUserState extends State<HistoryUser> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    // Get the UID of the logged-in user
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...',
            ),
            onChanged: (val) {
              setState(() {
                name =
                    val.toLowerCase(); // Convert the search query to lowercase
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('dataKlinis')
            .where('uid', isEqualTo: uid) // Filter data by UID
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final filteredData = snapshot.data!.docs.where((doc) {
              String dataName = doc["nama"]
                  .toString()
                  .toLowerCase(); // Convert the name in data to lowercase
              return name.isEmpty || dataName.startsWith(name);
            }).toList();

            return ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                var data = filteredData[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(
                    data["nama"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "UMUR : ${data["umur"]}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "HR : ${data["heartrate"]}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "SYSTOLIC : ${data["systolic"]}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "DIASTOLIC : ${data["diastolic"]}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "UMUR : ${data["umur"]}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "STATUS KESEHATAN : ${data["status_kesehatan"]}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
