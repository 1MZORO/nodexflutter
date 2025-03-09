import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> categories = [
    {"name": "Hoodies", "image": "assets/img/hoodie.png"},
    {"name": "Shorts", "image": "assets/img/shorts.png"},
    {"name": "Shoes", "image": "assets/img/shoes.png"},
    {"name": "Bag", "image": "assets/img/bag.png"},
    {"name": "Accessories", "image": "assets/img/accessorie.png"},
  ];

  final List<Map<String, String>> topSelling = [
    {"image": "assets/img/jacket.png", "price": "\$148.00"},
    {"image": "assets/img/sleeper.png", "price": "\$55.00"},
    {"image": "assets/img/jacket.png", "price": "\$60.00"},
    {"image": "assets/img/jacket.png", "price": "\$120.00"},
  ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchClt = TextEditingController();
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 5),
          child: Container(
              height: 43,
              width: 43,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(Icons.person)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18, top: 15),
            child: Image.asset(
              'assets/icons/img.png',
              height: 50,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: searchClt,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  fillColor: Colors.grey.shade100,
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("See All", style: TextStyle(fontSize: 14, color: Colors.blue)),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                            ),
                            child: Center(
                              child: Image.asset(categories[index]['image']!, height: 40),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(categories[index]['name']!, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),


              GridView.builder(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.7,
                ),
                itemCount: topSelling.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(topSelling[index]['image']!, height: 140, width: double.infinity, fit: BoxFit.cover),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Icon(Icons.favorite_border, color: Colors.black),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            topSelling[index]['price']!,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
