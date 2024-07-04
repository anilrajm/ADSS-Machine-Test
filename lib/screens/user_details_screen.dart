import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/post_provider.dart';

class UserDetailsScreen extends StatefulWidget {
  final String id;

  const UserDetailsScreen({super.key, required this.id});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final prov = Provider.of<PostProvider>(context, listen: false);

      prov.getAuthorById(id: widget.id);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Consumer<PostProvider>(
        builder: (context, PostProvider postProvider, child) {
          return postProvider.isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Center(
                child: Column(


                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Name: ${postProvider.author?.name ?? ''}",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Username: ${postProvider.author?.username ?? ''}",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Email: ${postProvider.author?.email ?? ''}",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Address: ${postProvider.author?.address?.fullAddress ?? ''}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
