import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qardan/core/theme/color_app.dart';
import 'dart:io';

class ContactUsViewbody extends StatefulWidget {
  @override
  _ContactUsViewbodyState createState() => _ContactUsViewbodyState();
}

class _ContactUsViewbodyState extends State<ContactUsViewbody> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> messages = [];
  File? _selectedImage;

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty || _selectedImage != null) {
      setState(() {
        messages.add({
          'text': _messageController.text.trim(),
          'image': _selectedImage, 
          'isMe': true, 
        });
        _messageController.clear();
        _selectedImage = null; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBar(
        title: Text('شاركنا مشكلتك'),
        backgroundColor: ColorApp.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorApp.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "أهلاً بيك! إحنا هنا علشان نساعدك تحل أي مشكلة بتقابلك.\n"
                        "شاركنا مشكلتك، وفريقنا هيكون معاك خطوة بخطوة لحلها.\n"
                        "هدفنا إنك تلاقي الحل بأسرع وقت!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Align(
                        alignment: message['isMe']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: message['isMe']
                                ? ColorApp.primaryColor
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (message['image'] != null)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Image.file(
                                    message['image'],
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              if (message['text'].isNotEmpty)
                                Text(
                                  message['text'],
                                  style: TextStyle(
                                    color: message['isMe']
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (_selectedImage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(_selectedImage!, height: 100),
            ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.image_outlined, color: ColorApp.black),
                onPressed: _pickImageFromGallery,
              ),
              IconButton(
                icon: Icon(Icons.camera_alt_outlined, color: ColorApp.black),
                onPressed: _pickImageFromCamera,
              ),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'رسالتك',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: ColorApp.black),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
