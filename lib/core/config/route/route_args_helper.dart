class ImagePreviewArgument {
  final String title;
  final String url;
  final String? tag;

  ImagePreviewArgument({
    required this.title,
    required this.url,
    this.tag,
  });
}

class EmailVerificationArgument {
  final String email;
  final bool fromProfile;

  EmailVerificationArgument({
    required this.email,
    required this.fromProfile,
  });
}

class AdminProductDetailArgument {
  final String productId;

  AdminProductDetailArgument({
    required this.productId,
  });
}
