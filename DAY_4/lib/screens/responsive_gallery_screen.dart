import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/common_widgets.dart';

class ResponsiveGalleryScreen extends StatelessWidget {
  static const routeName = '/responsive-gallery';

  const ResponsiveGalleryScreen({super.key});

  int _columnsForWidth(double width) {
    if (width >= 1200) return 6;
    if (width >= 800) return 4;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive GridView')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = _columnsForWidth(constraints.maxWidth);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionHeader(
                  title: 'Responsive Product Gallery',
                  subtitle:
                      'A gallery that adapts columns for mobile, tablet, and desktop.',
                ),
                Expanded(
                  child: GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: 50,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = sampleProducts[index];
                      return ProductCard(
                        product: product,
                        onAdd: () {},
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
