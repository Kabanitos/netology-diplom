FROM nginx:1.27.5-alpine
COPY html /usr/share/nginx/html
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80



