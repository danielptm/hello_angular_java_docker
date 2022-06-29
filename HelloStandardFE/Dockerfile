# FROM node:11
# RUN npm i -g http-server --save
# COPY dist/ dist/
# ENTRYPOINT ["http-server","./dist/HelloStandardFE/"]


FROM nginx
COPY /dist/HelloStandardFE /usr/share/nginx/html
COPY docker/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
