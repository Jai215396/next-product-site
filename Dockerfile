# DevOps Task 02 - Jaideep.
# Task: Updates to the project can be made directly to the root and additional configuration files may also be created as well.
# Let us Update the Dockerfile.

# Use official Node.js Base Image.
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy package files first (for better caching)
COPY package.json pnpm-lock.yaml* ./

# Install dependencies using pnpm
RUN pnpm install

# Copy the rest of the project
COPY . .

# Build the Next.js app
RUN pnpm build

# Expose the app port
EXPOSE 3000

# Start the app
CMD ["pnpm", "start"]
