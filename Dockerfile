# Start from the official Node.js LTS base image
FROM node:18

# Add the time to the build
RUN date -u +"%Y-%m-%dT%H:%M:%SZ" > /build-time.txt

# Set the working directory to /app
WORKDIR /app

# Copy the project files to the working directory
COPY . .

# Install project dependencies
RUN npm install

# Build the Next.js app
RUN npm run build

# Expose port 3000 for the Next.js app to be accessible
EXPOSE 3000

# Start the Next.js app
CMD ["npm", "start"]
