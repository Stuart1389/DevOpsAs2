# Use an official Node.js base image with a specific version
FROM node:14

# Copy the application files to the container
COPY webApp/ .

# Expose the port on which the app runs
EXPOSE 8090

# Command to run the application
CMD ["node", "server.js"]

