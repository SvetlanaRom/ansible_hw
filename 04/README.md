# Развёртывание ClickHouse, Vector и Lighthouse с помощью Ansible

Playbook автоматизирует установку и настройку связки для сбора, хранения и просмотра логов: **ClickHouse**, **Vector** и **Lighthouse** через **Nginx**.

## Что делает playbook

- **ClickHouse**: устанавливает пакеты, настраивает СУБД, создаёт БД и таблицу.
- **Vector**: устанавливает агент и конфигурирует отправку логов в ClickHouse.
- **Lighthouse и Nginx**: устанавливает Nginx, разворачивает веб-интерфейс Lighthouse и настраивает виртуальный хост.
- Перезапускает службы при обновлении конфигураций.

## Используемые roles

- **ClickHouse**
- **Vector**
- **Lighthouse**

## Требования

- **Ansible** версии 2.15+
- Остальные ограничения см в README.md ролей

## Настройка и параметры

### Inventory (`inventory/prod.yml`)
Укажите хосты для групп `clickhouse`, `vector` и `lighthouse` через переменные.

### Основные переменные (`group_vars/all.yml`)
Перечень переменных для ролей см в README.md ролей.  
Для inventory нужно указать:  
| Переменная | По умолчанию | Описание |
| --- | --- | --- |
| `lighthouse_host_ip` | `"84.201.130.220"` | IP-адрес сервера Lighthouse |
| `clickhouse_host_ip` | `"51.250.80.200"` | IP-адрес сервера ClickHouse |
| `vector_host_ip` | `"51.250.71.152"` | IP-адрес сервера Vector |
| `ansible_ssh_private_key_file` | `"~/.ssh/id_ed25519"` | путь до ключа для подключения к хостам |
| `ansible_user` | `"test"` | пользователь для подключения к хостам |

## Теги

В текущей конфигурации явные теги не заданы.

## Запуск

```bash
ansible-galaxy install -r requirements.yml -p roles
ansible-playbook site.yml -i inventory/prod.yml
```

## Проверка

Доступ к интерфейсу Lighthouse осуществляется по адресу `http://<lighthouse_host_ip>:8080/`, а к ClickHouse — через порт `8123`.
