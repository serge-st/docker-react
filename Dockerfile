# Build phase
# "AS builder" is a tag for the first phase
FROM node:alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# the above will build the app, and the prod verion of the app will be available in the /build directory inside the ROOT (or WORKDIR) directory.
# So the path to it is "/app/build"

# Serve phase
FROM nginx
# ! IMPORTANT the bellow was added later on, only for AWS elastic beanstalk
EXPOSE 80
# here we are reffering to the tag created in the first phase
COPY --from=builder /app/build /usr/share/nginx/html
# Default command for nginx server will start the server automatically so there is no "CMD"