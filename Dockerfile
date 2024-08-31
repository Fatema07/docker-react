# Stage 1: Build the React app
FROM node:alpine AS builder

# Set working directory
WORKDIR /app

# Copy the package.json and install dependencies
COPY package.json .

# Install dependencies
RUN npm install

# Copy all files from the current directory to the container
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the React app with NGINX
FROM nginx:alpine

# Copy the built files from the builder stage to the NGINX HTML directory
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
