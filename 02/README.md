# Развёртывание ClickHouse и Vector с помощью Ansible

Playbook автоматизирует установку и базовую настройку СУБД **ClickHouse** и агента сбора логов **Vector**.

## Что делает playbook

* Поддерживает развёртывание на виртуальных машинах и серверах под управлением **Ubuntu**.
* Устанавливает **ClickHouse** (`client`, `server`, `common-static`), запускает службу и создаёт пустую базу данных `logs`.
* Устанавливает **Vector** и разворачивает конфигурационный файл `/etc/vector/vector.yaml` из Jinja2-шаблона `templates/vector.yaml.j2`.
* Автоматически перезапускает службы при установке пакетов или изменении конфигурации (через `handlers`).

## Требования (Prerequisites)

* **Ansible** версии `2.15+` на управляющем узле.
* Целевые хосты с ОС **Ubuntu** (20.04 / 22.04 / 24.04) и доступом по SSH с правами `sudo`.

## Настройка и параметры (Configure)

### 1. Настройка Inventory (`inventory/prod.yml`)
Укажите IP-адреса серверов, логин и путь к приватному SSH-ключу для групп `clickhouse` и `vector`:

```yaml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: <IP_СЕРВЕРА_CLICKHOUSE>
      ansible_user: <ИМЯ_ПОЛЬЗОВАТЕЛЯ>
      ansible_ssh_private_key_file: ~/.ssh/id_rsa
vector:
  hosts:
    vector-01:
      ansible_host: <IP_СЕРВЕРА_VECTOR>
      ansible_user: <ИМЯ_ПОЛЬЗОВАТЕЛЯ>
      ansible_ssh_private_key_file: ~/.ssh/id_rsa
```

### 2. Переменные (`group_vars`)
Задайте версии устанавливаемого ПО в файлах переменных:

| Переменная | Описание | Пример значения |
| :--- | :--- | :--- |
| `clickhouse_version` | Версия устанавливаемых пакетов ClickHouse | `"22.8.5.29"` |
| `clickhouse_packages` | Список компонентов ClickHouse | `["clickhouse-common-static", "clickhouse-client", "clickhouse-server"]` |
| `vector_version` | Версия устанавливаемого агента Vector | `"0.61.0"` |

## Теги (Tags)

Пользовательские теги в данной версии playbook не используются.

## Запуск (Install)

```bash
# Проверка качества кода линтером
ansible-lint site.yml

# Запуск плейбука с отображением изменений
ansible-playbook site.yml -i inventory/prod.yml --diff
```
