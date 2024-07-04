import 'package:adss_machine_test/screens/post_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/post_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final prov = Provider.of<PostProvider>(context, listen: false);
      prov.getPost();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'Home Screen',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(child: Consumer(
          builder: (context, PostProvider postProvider, child) {
            return postProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostDetailsScreen(
                                      id: postProvider.postList[index].id
                                          .toString()),
                                ));
                          },
                          child: ListTile(
                            title: Text(
                              postProvider.postList[index].title ?? '',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text(postProvider.postList[index].body ?? ''),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: postProvider.postList.length);
          },
        )));
  }
}
