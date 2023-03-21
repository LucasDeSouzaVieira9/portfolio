import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/core/inject.dart';
import 'package:portfolio/feature/firebase/feature/storage/storage_screen_cubit.dart';
import 'package:portfolio/feature/firebase/feature/storage/storage_screen_state.dart';
import 'package:portfolio/feature/firebase/model/image_model.dart';
import 'package:portfolio/feature/nav/app_navigator.dart';
import 'package:portfolio/packages/instant_page_route.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  static const route = "storage_screen";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return const StorageScreen();
      },
    );
  }

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final cubit = StorageScreenCubit();
  final appNavigator = inject<AppNavigator>();

  User? user;

  final ImagePicker _picker = ImagePicker();
  List<ImageModel> images = [];
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;

    cubit.getImages(user!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorageScreenCubit, StorageScreenState>(
      bloc: cubit,
      listener: (context, state) {
        state.maybeWhen(
          deleteSuccess: (image) =>
              images.removeWhere((value) => image == value),
          uploadSuccess: (url) => images.add(url),
          success: (urlImages) {
            if (urlImages.isNotEmpty) {
              images = List.of(urlImages);
            }
          },
          orElse: () {},
        );
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                if (state is StorageScreenUploadLoadingState) ...[
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 20),
                ] else if (state is StorageScreenUploadSuccessState) ...[
                  const Icon(Icons.check),
                  const SizedBox(width: 20),
                ] else ...[
                  InkWell(
                    onTap: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        cubit.uploadImage(user!.uid, image);
                      }
                    },
                    child: const Icon(Icons.add_a_photo),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        cubit.uploadImage(user!.uid, image);
                      }
                    },
                    child: const Icon(Icons.add_photo_alternate_outlined),
                  ),
                  const SizedBox(width: 10),
                ],
              ],
            ),
            // Image.network()
          ],
          foregroundColor: Colors.black,
          centerTitle: true,
          backgroundColor: const Color(0xffFFCB2B),
          title: const Text('Storage', style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 27, 27),
        body: BlocConsumer<StorageScreenCubit, StorageScreenState>(
          bloc: cubit,
          listener: (context, state) {},
          builder: (context, state) => state.maybeMap(
            loading: (value) => const Center(
                child: CircularProgressIndicator(color: Color(0xffFFCB2B))),
            orElse: () => Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15),
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Image.network(
                              images[index].url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () =>
                            cubit.deleteImage(images[index], user!.uid),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffFFCB2B),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.delete),
                          ),
                        ),
                      )
                    ],
                  ),
                  itemCount: images.length,
                )),
          ),
        ),
      ),
    );
  }
}
