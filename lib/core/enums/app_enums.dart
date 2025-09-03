// Global enums
enum Environment { development, staging, production }

/// Enum to define user roles
enum UserRole { admin, user, guest }

/// Enum to define authentication status
enum AuthStatus { authenticated, unauthenticated, unknown }

/// Enum to define request status
enum RequestStatus { idle, loading, success, failure }

/// Enum to define the type of media to pick
enum MediaType { image, video }

/// Enum to define the source of media (camera or gallery)
enum MediaSource { camera, gallery }
