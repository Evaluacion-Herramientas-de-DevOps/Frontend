# Etapa 1: Compilación de React/Vite
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servidor de producción con Nginx y Proxy Inverso
FROM nginx:alpine
# Copiamos nuestra configuración del puente privado
COPY nginx.conf /etc/nginx/nginx.conf
# Copiamos el resultado de la compilación (Vite la deja en /dist)
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]