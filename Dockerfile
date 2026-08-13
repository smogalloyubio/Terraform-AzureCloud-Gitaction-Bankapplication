# Stage 1: Build Stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files for better caching
COPY package*.json ./

# Install all dependencies (including devDependencies for build)
RUN npm ci

# Copy application source
COPY . .

# Build the frontend and the mock backend
# This generates the 'dist' folder containing static assets and 'server.cjs'
RUN npm run build

# Stage 2: Production Dependencies Stage
FROM node:20-alpine AS deps-prod

WORKDIR /app

COPY package*.json ./

# Install only production dependencies
RUN npm ci --omit=dev

# Stage 3: Final Runtime Stage
FROM node:20-alpine AS runner

WORKDIR /app

# Create a non-root user for security
RUN addgroup -S simplebank && adduser -S simplebank -G simplebank

# Set environment to production
ENV NODE_ENV=production
ENV PORT=3000

# Copy build artifacts and production dependencies
COPY --from=builder /app/dist ./dist
COPY --from=deps-prod /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# Use the non-root user
USER simplebank

# Expose the application port
EXPOSE 3000

# Start the application using the bundled server
CMD ["node", "dist/server.cjs"]
