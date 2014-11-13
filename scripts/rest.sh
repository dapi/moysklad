
#   source ./tmp/test_env
resource=$1
action=$2

if [ -z "$MS_LOGIN" ] || [ -z "$MS_PASSWORD" ]; then
  echo "Утсановите переменные окружения MS_LOGIN и MS_PASSWORD"
  exit 1
fi

if [ -z "$resource" ]; then
  echo "Запуск: rest.sh Resoruce [action]"
  echo "Например: rest.sh Feature list"
  exit 2
fi


curl -is -u $MS_LOGIN:$MS_PASSWORD https://online.moysklad.ru/exchange/rest/ms/xml/$1/$2

