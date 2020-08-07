const writeFile = require('fs').writeFile;
const targetPath = './src/environments/environment.ts';

let hostname = process.env.API_BASE_URL !== undefined ? process.env.API_BASE_URL : 'localhost';  // non-local dev future proof? idk
let api_gateway_port = process.env.API_GATEWAY_PORT !== undefined ? process.env.API_GATEWAY_PORT : 7070;
let local = process.env.LOCAL_ENV !== undefined ? true : false;
let production = process.env.PRODUCTION_ENV !== undefined ? true : false;


// `environment.ts` file structure
const envConfigFile = `export const environment = {
   apiBaseUrl: '${hostname}',
   api_gateway_port: '${api_gateway_port}',
   local: ${local},
   production: ${production}
};
`;

console.log('The file `environment.ts` will be written with the following content: \n');
console.log(envConfigFile);
writeFile(targetPath, envConfigFile, function (err) {
   if (err) {
       throw console.error(err);
   } else {
       console.log(`Angular environment.ts file generated correctly at ${targetPath} \n`);
   }
});
