# --- CONFIG ---
PORT ?= 8080
SERVER_ENTRY := server.ts
CURL_URL := http://localhost:$(PORT)/moon.space.v1.TravelService/GetDestination

# --- RUN SERVER WITH HOT RELOAD ---
dev:
	bun run --watch $(SERVER_ENTRY)

# --- CURL TEST: GetDestination ---
curl:
	curl -X POST \
		-H "Content-Type: application/json" \
		--data '{"ref": "alaska"}' \
		$(CURL_URL)

# --- CLEANUP ---
clean:
	rm -rf node_modules

# --- INSTALL ---
install:
	bun install