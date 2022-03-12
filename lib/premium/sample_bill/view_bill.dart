import 'package:facelift_constructions/constants.dart';
import 'package:flutter/material.dart';

class ViewBillScreen extends StatelessWidget {
  final String name;
  final String image;
  final int amount;
  final int warrenty;
  final int date;
  final int month;
  final int year;
  const ViewBillScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.amount,
    required this.warrenty,
    required this.date,
    required this.month,
    required this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("View Bill", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => showImageDialogBox(context, image),
                  child: SizedBox(
                    height: 250,
                    width: size.width * 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(image, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                textPlace(context, name, "Name"),
                const SizedBox(height: 20),
                textPlace(context, "Rs $amount", "Amount"),
                const SizedBox(height: 20),
                textPlace(context, "$warrenty years", "Warrenty"),
                const SizedBox(height: 20),
                textPlace(context, "$date/$month/$year", "Date"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textPlace(BuildContext context, String text, String head) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: 50,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: pinkColor),
            borderRadius: BorderRadius.circular(32)),
        child: Center(
          child: SizedBox(
            width: size.width * 0.8,
            child: Text(
              "$head - $text",
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}
