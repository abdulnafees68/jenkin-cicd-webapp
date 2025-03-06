# Build Stage
FROM node:18 as build
WORKDIR /app
COPY package.json package-lock.json .
RUN npm install -g npm@11.2.0
COPY . .
RUN npm run build  # Build the Angular app

# Nginx Stage
FROM nginx:alpine
# Ensure the path matches your Angular build output directory
COPY --from=build /app/dist/hello-angular-app/browser  /usr/share/nginx/html

# Expose port 80 (or change to 9000 if needed)
EXPOSE 80

# Keep Nginx running in the foreground
CMD ["nginx", "-g", "daemon off;"]

