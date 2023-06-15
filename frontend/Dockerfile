FROM denoland/deno

WORKDIR /app
COPY vite.config.mts ./
RUN deno cache vite.config.mts
COPY ./ ./
CMD deno task dev --host
