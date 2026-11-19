Lighthouse
=========

Role автоматизирует установку и настройку **Lighthouse** через **Nginx**.

Requirements
------------
- Предустановка Python3 и Nginx на целевые хосты
- Целевые хосты с ОС **Ubuntu** и доступом по SSH с правами `sudo`.

Role Variables
--------------

Нет переменных, которые могут быть переопределены.

Dependencies
------------

Нет зависимостей

Example Playbook
----------------

  roles:
    - role: lighthouse

License
-------

MIT