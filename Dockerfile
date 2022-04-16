# Устанавливать зависимости только при необходимости
FROM node:14.17.1 AS deps

WORKDIR /app

# COPY package.json /app
COPY package.json package-lock.json ./ 

RUN npm install


# Пересобирать исходный код только при необходимости
FROM node:14.17.1 AS builder

WORKDIR /app

COPY . .
COPY --from=deps /app/node_modules ./node_modules

RUN yarn build

# Рабочий образ, скопируйте все файлы и запустите дальше
FROM node:14.17.1 AS runner

WORKDIR /app

# COPY . .
COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

#USER nextjs

ENV PORT 3000

EXPOSE $PORT

CMD ["npm", "start"]
