import 'package:skinscanning/src/core/base_import.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsCard extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? author;
  final String? tag;
  final String? time;
  final VoidCallback? onTap;
  final bool isLoading;

  const NewsCard({
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
          margin: const EdgeInsets.symmetric(vertical: 12), // Increased vertical margin for spacing
          padding: const EdgeInsets.symmetric(vertical: 12), // Increased vertical padding
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12), // Increased border radius
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? Image.network(
                  imageUrl!,
                  width: 150, // Increased image width
                  height: 150, // Increased image height
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 150, // Match increased image width
                      height: 150, // Match increased image height
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        size: 50, // Increased icon size
                        color: Colors.grey,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                )
                    : Container(
                  width: 150, // Match increased image width
                  height: 150, // Match increased image height
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50, // Increased icon size
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 16), // Increased horizontal spacing
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? '',
                      maxLines: 3, // Increased max lines for potentially longer titles
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18, // Increased font size
                      ),
                    ),
                    const SizedBox(height: 8), // Increased vertical spacing
                    Text(
                      "By ${author ?? ''}",
                      style: const TextStyle(
                        fontSize: 14, // Increased font size
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),  // Increased vertical spacing
                    Row(
                      children: [
                        Text(
                          tag ?? '',
                          style: const TextStyle(
                            fontSize: 14, // Increased font size
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12), // Increased horizontal spacing
                        Text(
                          time ?? '',
                          style: const TextStyle(
                            fontSize: 14, // Increased font size
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

