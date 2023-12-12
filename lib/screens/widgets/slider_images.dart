import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ImageSliderDemo extends StatefulWidget {
  List<String> list;
  ImageSliderDemo({required this.list});
  @override
  _ImageSliderDemoState createState() => _ImageSliderDemoState();
}

int _current = 0;
final CarouselController _controller = CarouselController();

class _ImageSliderDemoState extends State<ImageSliderDemo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: widget.list
                .map((e) => Center(
                        child: Stack(
                      children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: CachedNetworkImage(
                              imageUrl: e,
                              imageBuilder: (context, imageProvider) =>
                                  Image(image: imageProvider),
                              placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  ),
                              errorWidget: (context, url, error) {
                                print(error.toString());
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: HexColor('#07094D'),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )))
                .toList()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.list.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 6.0,
                height: 6.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
