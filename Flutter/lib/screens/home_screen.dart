import 'package:blogging_platform/models/blog.dart';
import 'package:blogging_platform/providers/blog_provider.dart';
import 'package:blogging_platform/screens/blog_view.dart';
import 'package:blogging_platform/screens/new_blog_screen.dart';
import 'package:blogging_platform/widgets/blog_preview.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Blog> allBlogs = [];

  _getBlogs() async {
    BlogProvider blogProvider = BlogProvider();
    allBlogs = await blogProvider.getBlogs();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            for (int i = 0; i < allBlogs.length; i++)
              InkWell(
                child: BlogPreview(
                  title: allBlogs[i].blogTitle,
                  image: allBlogs[i].blogImage,
                  blogId: allBlogs[i].blogId,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogView(
                        id: allBlogs[i].blogId,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewBlogScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
