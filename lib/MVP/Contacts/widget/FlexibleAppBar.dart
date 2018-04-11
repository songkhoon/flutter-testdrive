import 'package:flutter/material.dart';

class FlexibleAppBar extends SliverAppBar {
  static const double height = 256.0;

  FlexibleAppBar(String title, String imageUrl)
      : super(
          expandedHeight: height,
          flexibleSpace: new FlexibleSpaceBar(
            title: new Text(title),
            background: _buildBackground(imageUrl),
          ),
          pinned: true,
        );

  static Widget _buildBackground(String imageUrl) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: height,
        ),
        new DecoratedBox(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: <Color>[
              const Color(0x000000),
              const Color(0x9000000)
            ],
                    begin: const FractionalOffset(0.0, 0.6),
                    end: const FractionalOffset(0.0, 1.0))))
      ],
    );
  }
}
