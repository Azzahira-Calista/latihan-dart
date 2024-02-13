import 'package:flutter/material.dart';

class MyWatchList extends StatelessWidget {
  const MyWatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.movie_filter),
        title: const Text('NAMAVA'),
      ),
      body: const Center(
        child: Text('My Watch List'),
      ),
    );
  }
}