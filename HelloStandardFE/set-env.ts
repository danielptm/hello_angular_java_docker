const writeFile = require('fs').writeFile;
const targetPath = './src/environments/environment.ts';

let hostname = process.env.MINIKUBE_IP !== undefined ? process.env.MINIKUBE_IP : 'localhost';
let port = process.env.PORT !== undefined ? process.env.PORT : 80;
let prod = process.env.PROD_ENV !== undefined ? true : false;

// `environment.ts` file structure
const envConfigFile = `export const environment = {
   apiBaseUrl: '${hostname}:${port}/',
   production: '${prod}'
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
