FROM metasploitframework/metasploit-framework

RUN apk update && apk add --no-cache python3 py3-pip
RUN pip3 install --no-cache-dir fastapi uvicorn --break-system-packages

WORKDIR /app
COPY . /app

EXPOSE 8000

# تشغيل بايثون مباشرة لتفادي خطأ الحالة 128
CMD ["python3", "main.py"]
