Vector
=========

Role автоматизирует установку и настройку **Vector**.

Requirements
------------

- Предустановка Python3 на целевые хосты
- Целевые хосты с ОС **Ubuntu** и доступом по SSH с правами `sudo`.
- В playbook должна быть указана установка Clickhouse до установки Vector.

Role Variables
--------------

Все переменные, которые можно переопределить, хранятся в файле defaults/main.yml, а также в таблице ниже.

| Переменная | По умолчанию | Описание |
| --- | --- | --- |
| `vector_version` | `"0.61.0"` | Версия пакета Vector для установки |
| `clickhouse_host_ip` | `"127.0.0.1"` | IP-адрес сервера ClickHouse |
| `clickhouse_port` | `8123` | HTTP-порт подключения к ClickHouse |
| `clickhouse_db` | `"logs"` | Имя базы данных в ClickHouse |
| `clickhouse_table` | `"demo_syslog"` | Имя таблицы в ClickHouse |

Dependencies
------------

Нет зависимостей

Example Playbook
----------------

  roles:
    - role: vector

License
-------

MIT

