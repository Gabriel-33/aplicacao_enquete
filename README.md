# signo-app
# signo-app
Alguns arquivos não foram enviados diretamente para o git. Como por exemplo o "node_modules",sendo assim, rode/adicione os comandos/código abaixo para gerar os arquivos que são de infima importância para executar o sistema
O sistema foi desenvolvido em laravel 9 e vue js 2, com o banco de dados mysql.
rode "composer install","npm install" "copy .env.example .env" e "php artisan key:generate" na raiz do projeto. Depois, na mesma raiz do projeto, rode "node resources/js/server
Alterar o arquivo env. para:
APP_NAME=Laravel
APP_ENV=local
APP_KEY=base64:s0rPjdAf/JkfF7iPfZsmFAZ9JsexhaAIC05uitSfUMg=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=signo
DB_USERNAME=root
DB_PASSWORD=

BROADCAST_DRIVER=log
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS=null
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_APP_CLUSTER=mt1

MIX_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
MIX_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
