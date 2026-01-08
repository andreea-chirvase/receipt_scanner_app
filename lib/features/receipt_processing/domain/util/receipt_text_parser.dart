/// Base interface for all receipt text parsers from OCT text
/// Parse returns null if parsing fails or value not found
abstract class ReceiptTextParser<T> { 
  T? parse(String text);
}