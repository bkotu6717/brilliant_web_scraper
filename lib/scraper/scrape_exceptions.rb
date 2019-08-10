# frozen_string_literal: true

# List all the possible exceptions
module ScrapeExceptions
  GENERAL_EXCEPTIONS = [
    URI::InvalidURIError,
    RestClient::NotAcceptable,
    RestClient::BadGateway,
    RestClient::URITooLong,
    Encoding::CompatibilityError,
    RestClient::SeeOther,
    RestClient::LoopDetected,
    RestClient::PermanentRedirect,
    RestClient::Locked,
    RestClient::MethodNotAllowed,
    RestClient::NotImplemented,
    RestClient::PaymentRequired,
    RestClient::TooManyRequests,
    RestClient::RangeNotSatisfiable,
    Errno::ENETUNREACH,
    RestClient::Conflict,
    RestClient::ProxyAuthenticationRequired,
    Net::HTTPBadResponse,
    Errno::ECONNREFUSED,
    Errno::ECONNRESET,
    Errno::EHOSTUNREACH,
    Errno::EINVAL,
    OpenSSL::SSL::SSLError,
    RestClient::BadRequest,
    RestClient::Forbidden,
    RestClient::GatewayTimeout,
    RestClient::Gone,
    RestClient::InternalServerError,
    RestClient::MovedPermanently,
    RestClient::NotFound,
    RestClient::RequestFailed,
    RestClient::ServerBrokeConnection,
    RestClient::ServiceUnavailable,
    RestClient::SSLCertificateNotVerified,
    RestClient::Unauthorized,
    SocketError
  ].freeze

  TIMEOUT_EXCEPTIONS = [
    RestClient::Exceptions::OpenTimeout,
    RestClient::Exceptions::ReadTimeout,
    RestClient::RequestTimeout
  ].freeze
end
