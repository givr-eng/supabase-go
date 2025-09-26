module github.com/givr-eng/supabase-go

go 1.24.0

tool mvdan.cc/gofumpt

require (
	github.com/joho/godotenv v1.5.1
	github.com/supabase-community/auth-go v1.4.0
	github.com/supabase-community/functions-go v0.0.0-20220927045802-22373e6cb51d
	github.com/supabase-community/postgrest-go v0.0.11
	github.com/supabase-community/storage-go v0.7.0
)

require (
	github.com/google/go-cmp v0.7.0 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/tomnomnom/linkheader v0.0.0-20180905144013-02ca5825eb80 // indirect
	golang.org/x/mod v0.27.0 // indirect
	golang.org/x/sync v0.16.0 // indirect
	golang.org/x/tools v0.36.0 // indirect
	mvdan.cc/gofumpt v0.9.1 // indirect
)

replace github.com/supabase-community/postgrest-go => github.com/roja/postgrest-go v0.0.11

replace github.com/supabase-community/functions-go => github.com/roja/functions-go v0.0.2
