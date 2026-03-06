# النسخة الرسمية للميتاسبلويت
FROM metasploitframework/metasploit-framework

# استخدام apk بدلاً من apt-get لأن النظام Alpine
RUN apk update && apk add --no-cache python3 py3-pip

# تثبيت FastAPI و Uvicorn
RUN pip3 install --no-cache-dir fastapi uvicorn --break-system-packages

WORKDIR /app
COPY main.py /app/main.py

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
