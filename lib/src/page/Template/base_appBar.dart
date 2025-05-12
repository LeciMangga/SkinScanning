import 'package:skinscanning/src/core/base_import.dart';

class BaseAppbar extends StatelessWidget {
  const BaseAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset('assets/images/Logo.svg'),
      centerTitle: true,
    );
  }
}
