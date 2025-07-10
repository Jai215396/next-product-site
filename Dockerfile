# DevOps Task 02 - Jaideep.
# Task: Updates to the project can be made directly to the root and additional configuration files may also be created as well.
# Let us Update the Dockerfile.

# Install Dependencies.
FROM node:18-alpine AS deps
WORKDIR /app

COPY package.json package-lock.json* ./  
RUN npm install

# Build the Source Code.
FROM node:18-alpine AS builder
WORKDIR /app

COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN npm run build

# Production Image
FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV production

# Install Only Production Dependencies.
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

EXPOSE 3000
CMD ["npm", "start"]
