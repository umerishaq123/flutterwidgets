import 'dart:math';
import 'package:flutter/material.dart';

class WasteBasketScreen extends StatefulWidget {
  @override
  _WasteBasketScreenState createState() => _WasteBasketScreenState();
}

class _WasteBasketScreenState extends State<WasteBasketScreen> {
  List<WasteMaterial> wasteMaterials = [
    WasteMaterial(
      image: Image.asset('assets/images/papeer.png', width: 100, height: 100),
    ),
    WasteMaterial(
      image: Image.asset('assets/images/plastic.png', width: 100, height: 100),
    ),
    WasteMaterial(
      image: Image.asset('assets/images/glass.png', width: 100, height: 100),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag Waste to Basket'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Waste materials column
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                
                children: [
                  Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: wasteMaterials.map((material) {
                      return Draggable<WasteMaterial>(
                        data: material,
                        child: WasteMaterialWidget(material: material),
                        feedback: Material(
                          child: WasteMaterialWidget(material: material, isDragging: true),
                        ),
                        childWhenDragging: WasteMaterialWidget(material: material, isDragged: true),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          // Basket
          Expanded(
            child: DragTarget<WasteMaterial>(
              builder: (BuildContext context, List<WasteMaterial?> candidateData, List<dynamic> rejectedData) {
                return Stack(
                  children: [
                    // Basket image
                    Center(
                      child: Image.asset(
                        'assets/images/basket.jpg',
                        width: 200,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
              onAccept: (material) {
                setState(() {
                  wasteMaterials.remove(material);
                });

                // Optional: You can add further animation or effects here if needed.
                print('Material accepted: ${material.image}');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WasteMaterialWidget extends StatelessWidget {
  final WasteMaterial material;
  final bool isDragging;
  final bool isDragged;

  WasteMaterialWidget({required this.material, this.isDragging = false, this.isDragged = false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDragged ? 0.4 : 1.0,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            material.image,
          ],
        ),
      ),
    );
  }
}

class WasteMaterial {
  final Image image;

  WasteMaterial({required this.image});
}
