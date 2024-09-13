import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:moonscape_main/providers/upload_provider.dart';
import 'package:moonscape_main/utils/app_assets_finder.dart';
import 'package:moonscape_main/utils/py_image_handler.dart';

class SpaceOptionPage extends ConsumerStatefulWidget {
  const SpaceOptionPage({super.key});

  @override
  _SpaceOptionPageState createState() => _SpaceOptionPageState();
}

class _SpaceOptionPageState extends ConsumerState<SpaceOptionPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final uploadNotifier = ref.read(uploadProvider.notifier);

    final List<Map<String, dynamic>> spaceTypes = [
      {'name': 'Apartment', 'icon': "scan_type_1"},
      {'name': 'Beach house', 'icon': "scan_type_2"},
      {'name': 'Cabin', 'icon': "scan_type_3"},
      {'name': 'Camp', 'icon': "scan_type_4"},
      {'name': 'Castle', 'icon': "scan_type_5"},
      {'name': 'Container', 'icon': "scan_type_6"},
      {'name': 'Dome', 'icon': "scan_type_7"},
      {'name': 'Hall', 'icon': "scan_type_8"},
      {'name': 'Houseboat', 'icon': "scan_type_9"},
      {'name': 'Mansion', 'icon': "scan_type_10"},
      {'name': 'Room', 'icon': "scan_type_11"},
      {'name': 'Others', 'icon': "scan_type_12"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What type of space do',
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'you want to scan?',
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: Container(
                  width: 338,
                  height: 600,
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: spaceTypes.length,
                    itemBuilder: (context, index) {
                      final spaceType = spaceTypes[index];
                      final icons = spaceType["icon"];
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          Logger().i('Selected index: $selectedIndex');
                          setState(() {
                            selectedIndex = index;
                            Logger().i(selectedIndex == index);
                          });
                        },
                        child: Card(
                          color: selectedIndex == index
                              ? Colors.lightGreenAccent.shade100
                              : const Color(0xFFF5F5F5),
                          surfaceTintColor: selectedIndex == index ? Colors.lightGreenAccent.shade200 : const Color(0xFFF5F5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PyImageHelper.pngJpg(
                                  AppAssetsFinder.getPngPath(icons),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  spaceType['name']!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: 338,
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (image != null) {
                      uploadNotifier.uploadImage(image);
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(338, 52),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0XFFEEEEEE),
                    side: const BorderSide(color: Colors.black12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: 338,
        padding: const EdgeInsets.only(left: 26.0, right: 26.0, bottom: 30),
        child: ElevatedButton(
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
              source: ImageSource.gallery,
            );

            if (image != null) {
              uploadNotifier.uploadImage(image);
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(338, 52),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.grey.shade100,
            // backgroundColor: const Color(0XFFEEEEEE),
            // side: const BorderSide(
            //   color: Colors.black12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
          );
  }
}
