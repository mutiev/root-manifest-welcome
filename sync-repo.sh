git pull && git add . && git commit -m 'nginx location syntax' && git push


#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Путь к файлу, где будем хранить последнее сообщение
LAST_MSG_FILE="$SCRIPT_DIR/.last_git_sync_msg"

# Читаем последнее сообщение, если есть
if [ -f "$LAST_MSG_FILE" ]; then
    LAST_MSG=$(cat "$LAST_MSG_FILE")
else
    LAST_MSG="basic sync, no information were provided"
fi

# Спрашиваем у пользователя
echo "Enter commit message (press Enter to use last: \"$LAST_MSG\"):"
read -r MSG

# Если ничего не ввели — используем последнее, иначе — новое и сохраняем
if [ -z "$MSG" ]; then
    MSG="$LAST_MSG"
else
    echo "$MSG" > "$LAST_MSG_FILE"
fi

git pull
sleep 0.5
git add .
git commit -m "$MSG"
sleep 0.2
git push
echo "Done!"

