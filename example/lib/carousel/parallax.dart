import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonspace/carousel/curved_carousel.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';

class Parallax extends StatelessWidget {
  const Parallax({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedCarousel(
      count: DemoData.cities.length,
      height: 350,
      width: 230,
      scaleMin: 1,
      yMultiplier: 0,
      opacityMin: 1,
      rotationMultiplier: 0,
      animatedBuilder: (index, ratio) {
        return TravelCardRenderer(
          ratio,
          city: DemoData.cities[index],
          cardHeight: 340,
          cardWidth: 280,
        );
      },
    );
  }
}

class TravelCardRenderer extends StatelessWidget {
  final double offset;
  final double cardWidth;
  final double cardHeight;
  final City city;

  const TravelCardRenderer(
    this.offset, {
    super.key,
    this.cardWidth = 250,
    required this.city,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      margin: EdgeInsets.only(top: 8),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30, left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: city.color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4 * offset.abs()),
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10 + 6 * offset.abs(),
                ),
              ],
            ),
          ),

          Positioned(top: -15, child: _buildCityImageStack()),

          _buildCityInfo(context),
        ],
      ),
    ).animate().flipH(end: -(offset) * .4).scaleY(end: (1 - .3 * offset.abs()));
  }

  Widget _buildCityImageStack() {
    double cardPadding = 28;
    double containerWidth = cardWidth - cardPadding;
    return SizedBox(
      height: cardHeight,
      width: containerWidth,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: cardHeight * .45,
            child: Image.asset(
              "assets/location/${city.name}/${city.name}-Back.png",
              width: containerWidth * .8,
            ),
          ).animate().flipH(alignment: Alignment.center, end: -offset * .3),
          // .moveX(end: offset * 20),
          Positioned(
            bottom: cardHeight * .45,
            child: Image.asset(
              "assets/location/${city.name}/${city.name}-Front.png",
              width: containerWidth * .9,
            ),
          ).animate().flipH(alignment: Alignment.center, end: -offset * .1),
          // .moveX(end: offset * 20),
          Positioned(
            bottom: cardHeight * .45,
            child: Image.asset(
              "assets/location/${city.name}/${city.name}-Middle.png",
              width: containerWidth * .9,
            ),
          ).animate().flipH(alignment: Alignment.center, end: -offset * .2),
          // .moveX(end: offset * 20),
        ],
      ),
    ).animate().shakeX(
      duration: offset < .1 ? 500.ms : 0.ms,
      curve: Curves.decelerate,
      amount: 5,
      hz: 3,
    );
  }

  Widget _buildCityInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // The sized box mock the space of the city image
        SizedBox(width: double.infinity, height: cardHeight * .57),

        /// Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            city.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.agbalumo(textStyle: context.h5),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            city.description,
            textAlign: TextAlign.center,
            style: context.p.w3,
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}

class City {
  final String name;
  final String title;
  final String description;
  final Color color;
  final List<Hotel> hotels;

  City({
    required this.title,
    required this.name,
    required this.description,
    required this.color,
    required this.hotels,
  });
}

class Hotel {
  final String name;
  final double rating;
  final int reviews;
  final int price;

  Hotel(
    this.name, {
    required this.reviews,
    required this.price,
    required this.rating,
  });
}

class DemoData {
  static List<City> get cities => [
    City(
      name: 'Pisa',
      title: 'Pisa, Italy',
      description: 'Discover a beautiful city where ancient and modern meet',
      color: Color(0xffdee5cf),
      hotels: [
        Hotel('Hotel Bologna', reviews: 201, price: 120, rating: 4),
        Hotel('Tree House', reviews: 85, price: 98, rating: 5),
        Hotel(
          'Allegroitalia Pisa Tower Plaza',
          reviews: 128,
          price: 119,
          rating: 4,
        ),
      ],
    ),
    City(
      name: 'Budapest',
      title: 'Budapest, Hungary',
      description: 'Meet the city with rich history and indescribable culture',
      color: Color(0xffdaf3f7),
      hotels: [
        Hotel('Hotel Estilo Budapest', reviews: 762, price: 87, rating: 5),
        Hotel('Danubius Hotel', reviews: 3122, price: 196, rating: 3),
        Hotel(
          'Golden Budapest Condominium',
          reviews: 213,
          price: 217,
          rating: 5,
        ),
      ],
    ),
    City(
      name: 'London',
      title: 'London, England',
      description:
          'A diverse and exciting city with the world’s best sights and attractions!',
      color: Color(0xfff9d9e2),
      hotels: [
        Hotel(
          'InterContinental London Hotel',
          reviews: 1624,
          price: 418,
          rating: 3,
        ),
        Hotel('Brick Lane Hotel', reviews: 101, price: 101, rating: 4),
        Hotel('Park Villa Boutique House', reviews: 161, price: 128, rating: 5),
      ],
    ),
    City(
      name: 'Pisa',
      title: 'Pisa, Italy',
      description: 'Discover a beautiful city where ancient and modern meet',
      color: Color(0xffdee5cf),
      hotels: [
        Hotel('Hotel Bologna', reviews: 201, price: 120, rating: 4),
        Hotel('Tree House', reviews: 85, price: 98, rating: 5),
        Hotel(
          'Allegroitalia Pisa Tower Plaza',
          reviews: 128,
          price: 119,
          rating: 4,
        ),
      ],
    ),
    City(
      name: 'Budapest',
      title: 'Budapest, Hungary',
      description: 'Meet the city with rich history and indescribable culture',
      color: Color(0xffdaf3f7),
      hotels: [
        Hotel('Hotel Estilo Budapest', reviews: 762, price: 87, rating: 5),
        Hotel('Danubius Hotel', reviews: 3122, price: 196, rating: 3),
        Hotel(
          'Golden Budapest Condominium',
          reviews: 213,
          price: 217,
          rating: 5,
        ),
      ],
    ),
    City(
      name: 'London',
      title: 'London, England',
      description:
          'A diverse and exciting city with the world’s best sights and attractions!',
      color: Color(0xfff9d9e2),
      hotels: [
        Hotel(
          'InterContinental London Hotel',
          reviews: 1624,
          price: 418,
          rating: 3,
        ),
        Hotel('Brick Lane Hotel', reviews: 101, price: 101, rating: 4),
        Hotel('Park Villa Boutique House', reviews: 161, price: 128, rating: 5),
      ],
    ),
  ];

  List<City> getCities() => cities;
  List<Hotel> getHotels(City city) => city.hotels;
}
