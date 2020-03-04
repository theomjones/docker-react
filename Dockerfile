FROM node:alpine as builder
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- where stuff will be

FROM nginx as runner

# usually this is for communication to developers
# it's something to read and understand that ports need
# mapping. However AWS elastic beanstalk will look for this
# and map it automatically
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
# nginx image default command starts nginx