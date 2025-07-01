# ------------ Dockerfile -----------------
FROM python:3.12-slim

# tiny OS layer
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc build-essential && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY telegram_moderator_bot.py .

# only two deps
RUN pip install --no-cache-dir python-telegram-bot==21.8 langdetect

# non-root health & runtime directory
RUN adduser --disabled-password bot
USER bot
ENV DB_PATH=/data/bot.db TZ=UTC PYTHONUNBUFFERED=1

CMD ["python", "-u", "telegram_moderator_bot.py"]
