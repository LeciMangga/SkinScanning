import 'package:skinscanning/src/core/base_import.dart';
import 'package:skinscanning/src/page/Landing/landing_controller.dart';

class SearchingBar extends StatefulWidget {
  const SearchingBar({super.key});

  @override
  State<SearchingBar> createState() => _SearchingBarState();
}

class _SearchingBarState extends State<SearchingBar> {
  final LandingController controller = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {Get.snackbar('Search', value);},
        key: controller.searchFormKey,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.transparent,),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.transparent,),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.transparent,),
          ),
          fillColor: Color(0xFFF3F3F3),
          filled: true,
          hintText: 'Explore Skin Health Topics',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          )
        ),
      ),
    );
  }
}
