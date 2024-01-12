# Start from the node alpine image for smaller base image size
FROM node:alpine

# Set the working directory to /app
WORKDIR /app

# Copy the package.json to working directory to install first
COPY package.json .

# Install project dependencies
RUN npm install

# Copy the project files to the working directory
COPY . .

# Build the Next.js app
RUN npm run build

# Expose port 3000 for the Next.js app to be accessible
EXPOSE 3000

# Start the Next.js app
CMD ["npm", "start"]
