import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moonscape_main/3dView/view_in_3d.dart';
import 'package:moonscape_main/providers/upload_provider.dart';
import 'package:moonscape_main/screens/space_option_screen.dart';
import 'package:moonscape_main/utils/app_assets_finder.dart';
import 'package:moonscape_main/utils/py_image_handler.dart';
import 'package:moonscape_main/widgets/drawer.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int _selectedIndex = 0; // To track the selected tab

  // Items for bottom navigation bar
  final List<BottomNavigationBarItem> _bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'hoME',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.event),
      label: 'Event',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.location_city),
      label: 'Venue',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.collections),
      label: 'Collections',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.store),
      label: 'Vendors',
    ),
  ];

  // Widget content based on the selected tab
  Widget _buildContent(int index, Box box) {
    switch (index) {
      case 0:
        return _buildRecentCaptures(box);
      case 1:
        return const Center(child: Text('Event View'));
      case 2:
        return const Center(child: Text('Venue View'));
      case 3:
        return const Center(child: Text('Collections View'));
      case 4:
        return const Center(child: Text('Vendors View'));
      default:
        return _buildRecentCaptures(box);
    }
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(uploadProvider);
    final Box box = Hive.box('models');
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: (identifier) {}),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: PyImageHelper.svg(AppAssetsFinder.getSvgPath("logo")),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: PyImageHelper.svg(
              AppAssetsFinder.getSvgPath("menu_icon"),
              width: 20,
              height: 20,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE3E3E3),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "MA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold), // Ensure bold text
                ),
              ),
            ),
          ),
        ],
        bottom: const TabBar(
          tabs: [
            Tab(text: 'Recent captures'),
            Tab(text: 'Albums'),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
        ),
      ),
      body: _buildContent(_selectedIndex, box),
      floatingActionButton: uploadState.isUploading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            )
          : FloatingActionButton(
              backgroundColor: const Color(0xFFEFEFEF),
              onPressed: () => _startUploadProcess(context),
              child:
                  PyImageHelper.svg(AppAssetsFinder.getSvgPath("camera_icon")),
            ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: _bottomNavItems,
        selectedItemColor: Colors.black, // Similar to the second image
        unselectedItemColor: Colors.grey, // Similar to the second image
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  void _startUploadProcess(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) =>
          const SizedBox(height: 650, child: SpaceOptionPage()),
    );
  }

  Widget _buildRecentCaptures(Box box) {
    return box.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: box.length,
            itemBuilder: (context, index) {
              final modelData = Map<String, dynamic>.from(
                  box.getAt(index) as Map); // Ensure proper type casting
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModelViewerScreen(
                        modelData: modelData,
                        taskId: modelData['task_id'],
                      ),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Stack(
                          children: [
                            Container(
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey.shade200,
                              ),
                              child: PyImageHelper.svg(
                                AppAssetsFinder.getSvgPath(
                                    'splash_caption_main'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: PyImageHelper.svg(
                                AppAssetsFinder.getSvgPath('3d_icon'),
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Venue Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ), // Replace with modelData['name']
                            ),
                            SizedBox(height: 4),
                            Text('Date'), // Replace with modelData['date']
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PyImageHelper.svg(
                    AppAssetsFinder.getSvgPath("splash_caption_main")),
                const SizedBox(height: 16),
                const Text(
                  "No Scans available",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:moonscape_main/3dView/view_in_3d.dart';
// // import 'package:moonscape_main/examples/objectsonplanesexample.dart';
// import 'package:moonscape_main/providers/upload_provider.dart';
// import 'package:moonscape_main/screens/space_option_screen.dart';
// import 'package:moonscape_main/utils/app_assets_finder.dart';
// import 'package:moonscape_main/utils/py_image_handler.dart';
// import 'package:moonscape_main/widgets/drawer.dart';
// // import 'package:moonscape_main/display_ar/object_plane.dart';

// class DashboardPage extends ConsumerWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final uploadState = ref.watch(uploadProvider); // Watch the upload state
//     final Box box = Hive.box('models');

//     void _setScreen(String identifier) async {
//       Navigator.of(context).pop();
//       print("object");
//       // if (identifier == 'filters') {
//       //   await Navigator.of(context).push<Map<Filter, bool>>(
//       //     MaterialPageRoute(
//       //       builder: (ctx) => const FiltersScreen(),
//       //     ),
//       //   );
//     }

//     final _scaffoldKey = GlobalKey<ScaffoldState>();

//     return DefaultTabController(
//       length: 2, // Number of tabs
//       child: Scaffold(
//         drawer: MainDrawer(onSelectScreen: _setScreen),
//         backgroundColor: Colors.white,
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: PyImageHelper.svg(AppAssetsFinder.getSvgPath("logo")),
//           automaticallyImplyLeading: false,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 18.0),
//             child: InkWell(
//               onTap: () {
//                 _scaffoldKey.currentState?.openDrawer();
//               },
//               child: PyImageHelper.svg(
//                 AppAssetsFinder.getSvgPath("menu_icon"),
//                 width: 20,
//                 height: 20,
//               ),
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 18.0),
//               child: Container(
//                 width: 46,
//                 height: 46,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color(0xFFE3E3E3),
//                 ),
//                 child: const Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "MA",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold), // Ensure bold text
//                   ),
//                 ),
//               ),
//             ),
//           ],
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Recent captures'),
//               Tab(text: 'Albums'),
//             ],
//             labelColor: Colors.black,
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Colors.black,
//           ),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   _buildRecentCaptures(box),
//                   _buildAlbums(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: uploadState.isUploading
//             ? const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//               )
//             : FloatingActionButton(
//                 backgroundColor: const Color(0xFFEFEFEF),
//                 // onPressed: () => const ObjectsOnPlanesWidget(),
//                 onPressed: () => _startUploadProcess(context),
//                 child: PyImageHelper.svg(
//                     AppAssetsFinder.getSvgPath("camera_icon")),
//               ),
//       ),
//     );
//   }

//   void _startUploadProcess(BuildContext context) {
//     showModalBottomSheet(
//       showDragHandle: true,
//       context: context,
//       isScrollControlled: true,
//       isDismissible: true,
//       builder: (context) =>
//           const SizedBox(height: 650, child: SpaceOptionPage()),
//     );
//   }

//   Widget _buildRecentCaptures(Box box) {
//     return box.isNotEmpty
//         ? GridView.builder(
//             padding: const EdgeInsets.all(16.0),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//             ),
//             itemCount: box.length, // Dynamic count based on Hive box length
//             itemBuilder: (context, index) {
//               final modelData = Map<String, dynamic>.from(
//                   box.getAt(index) as Map); // Ensure proper type casting
//               return GestureDetector(
//                 onTap: () {
//                   // Navigate to ModelViewerScreen with the selected model data
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ModelViewerScreen(
//                         modelData: modelData,
//                         taskId: modelData['task_id'],
//                       ),
//                     ),
//                   );
//                 },
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Flexible(
//                         child: Stack(
//                           children: [
//                             Container(
//                               height: 160,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 color: Colors.grey.shade200,
//                               ),
//                               child: PyImageHelper.svg(
//                                 AppAssetsFinder.getSvgPath(
//                                     'splash_caption_main'),
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                             Positioned(
//                               top: 8,
//                               right: 8,
//                               child: PyImageHelper.svg(
//                                 AppAssetsFinder.getSvgPath('3d_icon'),
//                                 width: 24,
//                                 height: 24,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Venue Name',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ), // Replace with modelData['name']
//                             ),
//                             SizedBox(height: 4),
//                             Text('Date'), // Replace with modelData['date']
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           )
//         : Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 PyImageHelper.svg(
//                     AppAssetsFinder.getSvgPath("splash_caption_main")),
//                 const SizedBox(height: 16),
//                 const Text(
//                   "No Scans available",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           );
//   }

//   Widget _buildAlbums() {
//     return const Center(
//       child: Text('Albums View'),
//     );
//   }
// }
