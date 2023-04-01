import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lookalike/providers/image_provider.dart';
import 'package:lookalike/providers/prediction_provider.dart';

class Prediction extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lookalike'),
      ),
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          ref.watch(predictionProvider);

          final predictionData = ref.read(predictionProvider.notifier).value;
          final image = ref.read(imageProvider.notifier).value;

          if (predictionData == null) {
            return const CircularProgressIndicator();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: width,
                  height: height * .3,
                  child: Image.file(
                    image!,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: width,
                  height: height * .3,
                  child: Image.asset(
                    'images/${predictionData.name}.jpg'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                child: Text(
                  'You look like ${predictionData.name}',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
