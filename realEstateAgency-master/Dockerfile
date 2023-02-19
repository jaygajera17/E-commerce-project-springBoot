FROM node:14.13.0-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY client/package*.json ./client/
RUN npm install --prefix client
COPY . .
ARG REACT_APP_GOOGLE_MAP_API
ENV REACT_APP_GOOGLE_MAP_API=$REACT_APP_GOOGLE_MAP_API
RUN npm run build --prefix client
EXPOSE 5001
CMD [ "npm","start" ]
