import 'package:skinscanning/src/core/base_import.dart';

class SkinInfoCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SkinInfoCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.info_outline, size: 30, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
