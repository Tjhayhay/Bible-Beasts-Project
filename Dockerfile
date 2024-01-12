# Use a specific Node.js version and Alpine for the build stage for a smaller base image
FROM node:20-alpine as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory to install first
COPY package.json package-lock.json ./

# Install project dependencies
RUN npm ci

# Copy the project files to the working directory
COPY . .

# Build the Bible Beasts App app
RUN npm run build

# Use a smaller Alpine base image for the final runtime
FROM node:20-alpine

# Set the working directory
WORKDIR /app

# Copy built app from the previous build stage for a slimmer image
COPY --from=builder /app /app

# Expose port 3000 for the Bible Beast Project app to be accessible
EXPOSE 3000

# Start the Bible Beasts Projects app
CMD ["npm", "start"]
