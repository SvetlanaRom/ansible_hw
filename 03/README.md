# Развёртывание ClickHouse, Vector и Lighthouse с помощью Ansible

Playbook автоматизирует установку и настройку связки для сбора, хранения и просмотра логов: **ClickHouse**, **Vector** и **Lighthouse** через **Nginx**.

## Что делает playbook

- **ClickHouse**: устанавливает пакеты, настраивает CORS и внешние интерфейсы через `/etc/clickhouse-server/config.d/cors.xml`, создаёт БД `logs` и таблицу `demo_syslog`.
- **Vector**: устанавливает агент и конфигурирует отправку логов в ClickHouse.
- **Lighthouse и Nginx**: устанавливает Nginx, разворачивает веб-интерфейс Lighthouse и настраивает виртуальный хост.
- Перезапускает службы при обновлении конфигураций.

## Требования

- **Ansible** версии 2.15+
- Целевые хосты с ОС **Ubuntu** и доступом по SSH с правами `sudo`.

## Настройка и параметры

### Inventory (`inventory/prod.yml`)
Укажите хосты для групп `clickhouse`, `vector` и `lighthouse`.

### Основные переменные (`group_vars/all.yml`)
- `ansible_user`, `ansible_ssh_private_key_file` — параметры подключения.
- `clickhouse_host_ip`, `lighthouse_host_ip`, `vector_host_ip` -  ip адреса хостов
- `clickhouse_version`, `clickhouse_db`, `clickhouse_table`, `clickhouse_port` — настройки ClickHouse.
- `vector_version`, `clickhouse_version` — версии Vector и ClickHouse.
- `clickhouse_packages` - перечень пакетов для ClickHouse.
- `lighthouse_configs_dir` — путь к статике Lighthouse.
- `lighthouse_nginx_conf_template` - конфиг для nginx

## Теги

В текущей конфигурации явные теги не заданы.

## Запуск

```bash
ansible-playbook site.yml -i inventory/prod.yml
```

## Проверка

Доступ к интерфейсу Lighthouse осуществляется по адресу `http://<lighthouse_host_ip>:8080/`, а к ClickHouse — через порт `8123`.
