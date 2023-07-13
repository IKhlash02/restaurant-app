// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project_1/data/api/api_service.dart';
import 'package:project_1/provider/add_review_provider.dart';
import 'package:project_1/widget/submit_button.dart';
import 'package:provider/provider.dart';

class AddReviewPage extends StatefulWidget {
  final String pictureId;
  final String name;
  const AddReviewPage({
    Key? key,
    required this.pictureId,
    required this.name,
  }) : super(key: key);

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final double rating = 0.0;

  final TextEditingController _addReviewController = TextEditingController();
  @override
  void dispose() {
    _addReviewController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue[300],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            "Beri Ulasan",
                            style: GoogleFonts.montserrat(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Image.network(
                    "${ApiService.imageLarge}${widget.pictureId}",
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _addReviewController,
                    maxLines:
                        null, // Membuat TextField bisa mengisi lebih dari satu baris teks
                    keyboardType: TextInputType
                        .multiline, // Mengaktifkan keyboard dengan fitur multiline
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          bottom: 40.0, top: 8, right: 8, left: 8),
                      isDense: true,
                      hintText: 'Ketik ulasan anda..',
                      hintStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5,
                      ),
                      fillColor: Colors.blue[100],
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.47)),
                      // Tambahkan properti dekorasi lain yang Anda butuhkan
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SubmitButton(
                      text: "Add Review",
                      onPressed: () {
                        final review = _addReviewController.text;
                        Provider.of<AddReviewProvider>(context, listen: false)
                            .addReview(review);

                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
