# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Go client library for Supabase that provides an isomorphic interface to Supabase services. The library integrates with:
- Postgrest for database operations via REST API
- GoTrue for authentication (email/password, phone/password, OAuth)
- Supabase Storage for file management
- Supabase Edge Functions for serverless function execution

## Architecture

### Core Components

- `client.go`: Main client implementation that orchestrates all Supabase services
- `Client` struct: Central client that wraps individual service clients (REST, Auth, Storage, Functions)
- Service integration through community Go libraries with custom forks

### Key Design Patterns

- **Unified Client**: Single entry point that manages authentication state across all services
- **Token Management**: Automatic token refresh with exponential backoff retry logic
- **Session Propagation**: When authentication state changes, all service clients are updated automatically
- **Wrapper Methods**: Client provides convenience methods that wrap underlying service operations

### Authentication Flow

The client handles authentication centrally:
1. Sign-in methods return session data and automatically update all service clients
2. `UpdateAuthSession()` propagates new tokens to all services (REST, Storage, Functions)
3. `EnableTokenAutoRefresh()` runs background goroutine for automatic token renewal

## Development Commands

### Testing
```bash
# Run all tests
go test ./...

# Run specific test
go test -run TestFrom
go test -run TestAuth

# Run tests with verbose output
go test -v ./...
```

### Building
```bash
# Build the module
go build ./...

# Check module dependencies
go mod tidy
go mod verify
```

### Module Management
```bash
# Download dependencies
go mod download

# Update dependencies
go get -u ./...

# Check for vulnerabilities
go vet ./...
```

## Testing Strategy

### Unit Tests
- Tests are in `client_test.go` using standard Go testing
- Integration tests require real Supabase credentials (API_URL and API_KEY constants)
- Each major service has dedicated test functions (TestFrom, TestRpc, TestStorage, TestFunctions)

### Remote Testing
- `test/remote_client.go` provides example usage with environment variables
- Requires `.env` file with SUPABASE_URL, SUPABASE_ANON_KEY, TESTUSER, TESTUSERPASSWORD

## Key Dependencies

- `github.com/supabase-community/auth-go`: Authentication client
- `github.com/supabase-community/postgrest-go`: Database REST API client
- `github.com/supabase-community/storage-go`: File storage client
- `github.com/supabase-community/functions-go`: Edge functions client

Note: This project uses custom forks for postgrest-go and functions-go (see go.mod replace directives).

## Common Development Tasks

### Adding New Authentication Methods
1. Add method to Client struct that wraps the auth-go equivalent
2. Ensure `UpdateAuthSession()` is called to propagate tokens
3. Return the session for further use

### Extending Database Operations
Database operations are delegated to the postgrest-go client via the `From()` method. New database features should be added upstream to postgrest-go rather than in this client.

### Error Handling
- All public methods should return meaningful errors
- Authentication errors should be propagated from underlying clients
- Network errors should be handled gracefully with retries where appropriate