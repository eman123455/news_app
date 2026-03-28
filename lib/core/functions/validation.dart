
class Validation {
  static String? fullNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < 3) {
      return 'Full name must be at least 3 characters';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final emailRegex = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    // Accepts optional +2 country code, then 0, then 9-14 digits
    final pattern = r'^(\+2)?0\d{9,14}$';
    if (!RegExp(pattern).hasMatch(value.trim())) {
      return 'Please enter a valid phone number (must start with 0, 10-15 digits, optional +2)';
    }
    return null;
  }

  static String? bioValidator(String? value) {
    if (value != null && value.length > 200) {
      return 'Bio must not exceed 200 characters';
    }
    return null;
  }

  static String? countryValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your country';
    }
    if (value.trim().length < 2) {
      return 'Full name must be at least 3 characters';
    }
    return null;
  }

  static String? websiteValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Website is optional
    }
    String pattern = r'^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\- ./?%&=]*)?$';
    if (!RegExp(pattern).hasMatch(value.trim())) {
      return 'Please enter a valid website URL';
    }
    return null;
  }
    static String? newsTitleValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }
    return null;
  }

 static String? newsCountryValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Country is required';
    }
    if (value.trim().length < 2) {
      return 'Country must be at least 2 characters';
    }
    return null;
  }

   static String? newsContentValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Content is required';
    }
    if (value.trim().length < 10) {
      return 'Content must be at least 10 characters';
    }
    return null;
  }

 static String? newsCategoryValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Category is required';
    }
    return null;
  }
}
