FROM nginx:alpine
COPY firstproject.html /usr/share/nginx/html/index.html
EXPOSE 80