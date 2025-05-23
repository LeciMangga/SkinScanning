import 'package:skinscanning/src/core/base_import.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LandingNewsCard extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? author;
  final String? tag;
  final String? time;
  final VoidCallback? onTap;
  final bool isLoading;

  const LandingNewsCard({
    super.key,
    this.imageUrl,
    this.title,
    this.author,
    this.tag,
    this.time,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageUrl != null
                    ? Image.network(
                  imageUrl!,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 90,
                  height: 90,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "By ${author ?? ''}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          tag ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          time ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
