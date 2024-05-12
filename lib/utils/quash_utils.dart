enum Severity { low, medium, high }

Severity getSeverityFromError(String error) {
  if (error.contains('FormatException')) {
    return Severity.low;
  } else if (error.contains('FileSystemException')) {
    return Severity.medium;
  } else {
    return Severity.high;
  }
}
