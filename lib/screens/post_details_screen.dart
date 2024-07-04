import 'package:adss_machine_test/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/post_provider.dart';

class PostDetailsScreen extends StatefulWidget {
  final String id;

  const PostDetailsScreen({super.key, required this.id});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final prov = Provider.of<PostProvider>(context, listen: false);
      prov.getPostById(id: widget.id);
      prov.getAuthorById(id: widget.id);
      prov.getCommentById(id: widget.id);
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDetailsScreen(
                                      id: postProvider.author?.id.toString() ??
                                          ''),
                                ));
                          },
                          child: Text(
                            "Author: ${postProvider.author?.name ?? ''}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          postProvider.individualPost?.title ?? '',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          postProvider.individualPost?.body ?? '',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Comments",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        if(
                        postProvider.isCommentsLoading
                        )
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        else
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: postProvider.comment
                              .map((e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.name ?? '',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        e.email ?? '',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        e.body ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    ));
  }
}
