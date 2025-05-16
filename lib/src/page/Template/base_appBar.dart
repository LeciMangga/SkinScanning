import 'package:skinscanning/src/core/base_import.dart';

class BaseAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset('assets/images/Logo.svg'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: (){
            Auth.to.GetFireBaseAuth().signOut();
            Get.offAllNamed('/login');
          },
          icon: Icon(Icons.logout, color: Colors.red,))
      ],
    );
  }
}
