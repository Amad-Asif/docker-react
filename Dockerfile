# tag this phase as builder
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# First phase will build up these dependencies and output the build folder, this build folder will be created in working directory like /app/build

# Now write for the run phase, FROM starts the second phase
FROM nginx
# Elastic beanstalk will map this port to incomming traffic
EXPOSE 80
# Nginx serves static content from the /usr/share/nginx/html directory
COPY --from=builder /app/build /usr/share/nginx/html
# The default command for Nginx starts the server so no extra command here is requried