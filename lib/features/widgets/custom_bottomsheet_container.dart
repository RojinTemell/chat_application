import 'package:flutter/material.dart';

class CustomBottomSheetContainer extends StatelessWidget {
  const CustomBottomSheetContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.12,
          ),
          Image.asset('assets/stromae.jpeg',
              width: size.width * 0.55,
              height: size.height * 0.25,
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text('Alors on Danse',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
          ),
          Text('Stromae',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.normal)),
          SizedBox(
            height: size.height * 0.04,
          ),
          const _customRowWidget(
            icon: Icons.add,
            text: 'Add to playlist',
          ),
          const _customRowWidget(
            icon: Icons.share,
            text: 'Share',
          ),
           SizedBox(
            height: size.height * 0.08,
          ),
        ],
      ),
    );
  }
}

class _customRowWidget extends StatelessWidget {
  const _customRowWidget({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
