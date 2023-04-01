import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lookalike/providers/image_provider.dart';
import 'package:lookalike/providers/prediction_provider.dart';
import 'package:lookalike/routes.dart';

class MyHomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(

      appBar: AppBar(
        title: const Text('Lookalike'),
      ),

      body: Center(
        child: Column(
          children: [

            const SizedBox(
              height: 10,
            ),

            Consumer(
              builder: (context, ref, child) {
                ref.watch(imageProvider);
                final image = ref.read(imageProvider.notifier).value;

                if(image == null) {
                  return SizedBox(
                    width: width * .8,
                    height: height * .5,
                  );
                }

                return SizedBox(
                  width: width * .8,
                  height: height * .5,
                  child: Image.file(
                    image,
                  ),
                );
              },
            ),

            Consumer(
              builder: (context, ref, child) {
                ref.watch(imageProvider);
                final image = ref.read(imageProvider.notifier).value;

                if(image == null) {
                  return Container();
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),

                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(predictionProvider.notifier).setPredictionData = null;
                      ref.read(predictionProvider.notifier).uploadImage(image);
                      Navigator.of(context).pushNamed(predictionRoute);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.upload,
                          size: 28,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: Text(
                            'Upload',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
              child: ElevatedButton(
                onPressed: () async {

                  await ref.read(imageProvider.notifier).getImage();

                  final image = ref.read(imageProvider.notifier).value;

                  if(image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No image selected'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(29, 194, 95, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.attach_file,
                      size: 28,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Text(
                        'Select photo',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
