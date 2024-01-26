# Docker-команда FROM вказує базовий образ контейнера
# Наш базовий образ - це Linux з попередньо встановленим python
FROM python:3.11

# Встановимо змінну середовища
ENV Ninth_repo /app

# Встановимо робочу директорію всередині контейнера
WORKDIR $Ninth_repo

# Встановимо залежності всередині контейнера
COPY pyproject.toml $Ninth_repo/pyproject.toml
COPY poetry.lock $Ninth_repo/poetry.lock

RUN pip install poetry
RUN poetry config virtualenvs.create false && poetry install --only main

# Скопіюємо інші файли в робочу директорію контейнера
COPY . .

# Позначимо порт, де працює застосунок всередині контейнера
EXPOSE 3000

# Запустимо наш застосунок всередині контейнера
ENTRYPOINT ["python", "main.py"]