FROM node:18.16.0-bullseye AS build

WORKDIR /app

COPY ./app/package*.json ./
RUN --mount=type=cache,target=/root/.npm npm install

COPY ./app /app

RUN npm run build

FROM node:18.16.0-bullseye-slim

WORKDIR /app

COPY --from=build /app/package*.json ./
COPY --from=build /app/build ./build

CMD ["node", "build"]
