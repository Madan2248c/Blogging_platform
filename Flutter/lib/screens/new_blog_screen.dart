import 'dart:io'; // Add this to work with File for the image

import 'package:blogging_platform/models/blog.dart';
import 'package:blogging_platform/providers/blog_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this for image selection

class NewBlogScreen extends StatefulWidget {
  const NewBlogScreen({super.key});

  @override
  State<NewBlogScreen> createState() => _NewBlogScreenState();
}

class _NewBlogScreenState extends State<NewBlogScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitBlog() {
    if (_image != null &&
        _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      BlogProvider blogProvider = BlogProvider();
      Blog blog = Blog(
          blogImage: _image!.path,
          blogTitle: _titleController.text,
          blogDescription: _descriptionController.text);
      var response = blogProvider.createBlog(blog);
      print(response);
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _image = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Blog uploaded successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(CupertinoIcons.back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Create a New Blog'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: _image != null
                      ? Image.file(_image!, height: 200, fit: BoxFit.cover)
                      : Container(
                          height: 200,
                          color: Colors.grey[200],
                          child: Icon(Icons.add_a_photo,
                              size: 50, color: Colors.grey[500]),
                        ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitBlog,
                  child: Text('Upload Blog'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
