FROM amd64/node:20-alpine3.19 AS build

# set working directory
WORKDIR /app

# install app dependencies
COPY package.json package-lock.json ./
RUN npm install

# add app
COPY . ./

RUN npm run build

# step 2
FROM nginx:latest

COPY default.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/build /usr/share/nginx/html

# Copy the script into the container
COPY start.sh /start.sh

# Make sure the script is executable
RUN chmod +x /start.sh

EXPOSE 80
EXPOSE 443

# EXPOSE 3000
# start app
CMD ["/start.sh"]