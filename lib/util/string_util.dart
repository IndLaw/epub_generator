library epub_generator;


class StringUtil {
  /**
   * Returns the file extension, such as .jpg
   */
  /// @param fileName filename
  /// @return extension


  static String getFileExtension(String fileName){
      return fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length);
  }
}


