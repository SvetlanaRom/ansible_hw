#!/bin/bash
set -euo pipefail

INVENTORY="inventory/prod.yml"
VAULT_PASS=".ansible_vault_pass"

CONTAINER_UBUNTU="ubuntu"
CONTAINER_ROCKY="rockylinux9"

cleanup() {
    echo -e "\n[+] Остановка Docker-контейнеров ..."
    docker stop $CONTAINER_UBUNTU $CONTAINER_ROCKY 2>/dev/null || true
    echo "[+] Контейнеры остановлены."
}

trap cleanup EXIT INT TERM

echo "[+] Запуск существующих Docker-контейнеров..."
docker start $CONTAINER_UBUNTU
docker start $CONTAINER_ROCKY

echo "[+] Ожидание инициализации сети внутри контейнеров (2 секунды)..."
sleep 2

echo "[+] Запуск Ansible Playbook..."
ansible-playbook site.yml -i "$INVENTORY" --vault-password-file "$VAULT_PASS"

echo "[+] Сценарий успешно завершен!"
