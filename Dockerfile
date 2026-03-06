# استخدام نسخة الميتاسبلويت الرسمية
FROM metasploitframework/metasploit-framework

# تحديث النظام وتثبيت بايثون باستخدام مدير حزم Alpine
RUN apk update && apk add --no-cache python3 py3-pip

# تثبيت مكتبات السيرفر
RUN pip3 install --no-cache-dir fastapi uvicorn --break-system-packages

# تجهيز ملفات العمل
WORKDIR /app
COPY main.py /app/main.py

# تشغيل السيرفر
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
