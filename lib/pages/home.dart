import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/admin/services/database.dart';
import 'package:food_app/pages/details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = true, burger = false, salad = false;
  Stream<QuerySnapshot>? fooditemStream;

  @override
  void initState() {
    super.initState();
    loadFood("pizza");
  }

  Future<void> loadFood(String category) async {
    fooditemStream = await DatabaseMethods().getFoodItem(category);
    setState(() {});
  }

  // ---------------- HORIZONTAL ITEMS ----------------
  Widget horizontalItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: fooditemStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final ds = snapshot.data!.docs[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    image: ds["Image"],
                    name: ds["Name"],
                    price: ds["Price"],
                    detail: ds["Detail"],
                  ),
                ),
              ),
              child: Container(
                width: 180,
                margin: const EdgeInsets.all(8),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            ds["Image"],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 80),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ds["Name"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "₹${ds["Price"]}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ---------------- VERTICAL ITEMS ----------------
  Widget verticalItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: fooditemStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final ds = snapshot.data!.docs[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    image: ds["Image"],
                    name: ds["Name"],
                    price: ds["Price"],
                    detail: ds["Detail"],
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            ds["Image"],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 60),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ds["Name"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Fresh and healthy",
                                style: TextStyle(color: Colors.black38),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₹${ds["Price"]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ---------------- CATEGORY ICONS ----------------
  Widget categoryIcons() {
    Widget buildIcon(String image, bool active, VoidCallback onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: active ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(image, height: 45, width: 45),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIcon("assets/images/icecreame.jpg", icecream, () {
          icecream = true;
          pizza = burger = salad = false;
          loadFood("icecream");
        }),
        buildIcon("assets/images/pizza.jpeg", pizza, () {
          pizza = true;
          icecream = burger = salad = false;
          loadFood("pizza");
        }),
        buildIcon("assets/images/salad.jpeg", salad, () {
          salad = true;
          pizza = burger = icecream = false;
          loadFood("salad");
        }),
        buildIcon("assets/images/burger.jpeg", burger, () {
          burger = true;
          pizza = icecream = salad = false;
          loadFood("burger");
        }),
      ],
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Hello Ankush",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.shopping_cart),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Delicious food",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Discover and get best food",
                style: TextStyle(color: Colors.black38),
              ),
              const SizedBox(height: 20),
              categoryIcons(),
              const SizedBox(height: 20),
              SizedBox(height: 260, child: horizontalItems()),
              const SizedBox(height: 20),
              verticalItems(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
