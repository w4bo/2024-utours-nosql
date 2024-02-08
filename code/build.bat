IF EXIST ".env" (
  echo .env already exists
) ELSE (
  copy .env.example .env
)
docker-compose build
npm install
