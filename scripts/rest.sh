
#   source ./tmp/test_env
resource=$1
action=$2
start=$3

if [ -z "$MS_LOGIN" ] || [ -z "$MS_PASSWORD" ]; then
  echo "Утсановите переменные окружения MS_LOGIN и MS_PASSWORD"
  exit 1
fi

if [ -z "$resource" ]; then
  echo "Запуск: rest.sh Resoruce [action]"
  echo "Например: rest.sh entity product"
  exit 2
fi

# url_v1.0="https://online.moysklad.ru/exchange/rest/ms/xml/$1/$2"
# url="https://online.moysklad.ru/api/remap/1.1/"
url="https://online.moysklad.ru/api/remap/1.1/$resource/$action"

if [ "$action"=="list" ] && [ -n "$start" ]; then
  url="$url?start=$start"
fi

echo $url >&2
url="https://online.moysklad.ru/api/remap/1.1/entity/variant/metadata/characteristics/3e277152-78ac-11e4-7a07-673c000ca568"
curl --max-redirs 3 -is -u $MS_LOGIN:$MS_PASSWORD $url

