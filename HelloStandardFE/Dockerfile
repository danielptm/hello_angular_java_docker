FROM node:11
RUN npm i -g http-server --save
COPY dist/ dist/
ENTRYPOINT ["http-server","./dist/HelloStandardFE/"]
