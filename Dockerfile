# Start from the official Node.js LTS base image
FROM node:alpine

# Set the working directory to /app
WORKDIR /app

# Copy the project files to the working directory
COPY package.json .

# Install project dependencies
RUN npm ci

COPY . .

# Build the Next.js app
RUN npm run build

# Expose port 3000 for the Next.js app to be accessible
EXPOSE 3000

# Start the Next.js app
CMD ["npm", "start"]
