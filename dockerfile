# Use a specific version of a minimal base image
FROM golang:1.17-alpine3.14 AS build

# Install GCC and other necessary build dependencies
RUN apk add --no-cache gcc musl-dev

# Set the working directory inside the container
WORKDIR /app

# Copy the Go modules files to enable caching of dependencies
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the application source code
COPY . .

# Build the Go application
RUN go build -a -o app .

#################################################
# multi-stage 

# Use a specific version of the minimal base image for multi-stage technique
FROM alpine:3.14.2

# Set the working directory inside the container
WORKDIR /app

# Copy the built executable from the previous stage
COPY --from=build /app/app .

# Create a non-root user with a specific UID 
# better for security reasons to run as non-root user
RUN adduser -D -u 1001 appuser

# Set the ownership of the application directory
RUN chown -R appuser:appuser /app

# Switch to the non-root user
USER appuser

# Expose port 9090
EXPOSE 9090

# sleep for a while until database is fully initialized then Run the application
CMD sleep 20 && ./app