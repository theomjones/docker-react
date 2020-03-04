FROM node:alpine as builder
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- where stuff will be

FROM nginx as runner
COPY --from=builder /app/build /usr/share/nginx/html
# nginx image default command starts nginx