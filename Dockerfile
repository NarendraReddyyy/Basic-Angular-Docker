# # Stage 1: Build the Angular application
# FROM node:18 AS build

# # Setup the working directory
# WORKDIR /usr/src/app

# # Copy package.json and package-lock.json
# COPY package.json package-lock.json ./

# # Install dependencies
# RUN npm install

# # Copy other files and folders to the working directory
# COPY . .

# # Build Angular application in PROD mode
# RUN npm run build --prod

# # Stage 2: Serve the application using Nginx
# FROM nginx:alpine

# # Copy built Angular app files to Nginx HTML folder
# COPY --from=build /usr/src/app/dist/angular-basic /usr/share/nginx/html

# # Expose port 80
# EXPOSE 80

# # Start Nginx server
# CMD ["nginx", "-g", "daemon off;"]


# Stage 1: Build the Angular App
FROM node:18 AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --configuration=production

# Stage 2: Serve Angular App using Nginx
FROM nginx:alpine
COPY --from=build-stage /app/dist/angular-basic /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
