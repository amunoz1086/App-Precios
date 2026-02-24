#  APLICACIÓN PRICING v1.0.32
App para el control de precios preferenciales bancoomeva

## REQUISITOS
1. node js
2. next js
3. mysql 8.0.29
4. alpine Linux v3.15

## DOCKER FILE
1. Actualizar librerias alpine 3.15 
``RUN apk update``

3. Instalar Node js y npm
``RUN apk add --update nodejs npm``

4. Crear el directorio /app y seleccionarlo
``RUN mkdir -p /app``
``WORKDIR /app ``

5. Compilar aplicación
``RUN npm run build``

6. Exponer puertos
``EXPOSE 3000``

7. Correr aplicación
``CMD ["npm","start"]``

## Para generar la imagen correr la siguiente instrucción
``docker build -t app_pricing:1 .``

## Para generar el contenedor correr la siguiente instrucción
``docker create -p 3000:3000 --name pricing app_pricing:1``