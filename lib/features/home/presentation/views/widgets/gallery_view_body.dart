import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qardan/features/home/presentation/views/widgets/divider.dart';

class GalleryViewBody extends StatelessWidget {
 const GalleryViewBody({required this.images});

 final List<File> images;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصور الملتقطة'),
        centerTitle: true,
        leading:  IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.pop(context),
                        ),
      ),
      body: Column(
        children: [
           Center(child: customDivider()),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.file(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
