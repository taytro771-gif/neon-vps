# استخدام نسخة الميتاسبلويت الرسمية
FROM metasploitframework/metasploit-framework

# تحديث النظام وتثبيت بايثون
RUN apk update && apk add --no-cache python3 py3-pip

# تثبيت المكتبات (مع تجاهل تحذيرات النظام)
RUN pip3 install --no-cache-dir fastapi uvicorn --break-system-packages

# تجهيز المجلد والملفات
WORKDIR /app
COPY main.py /app/main.py

# فتح المنفذ الأساسي
EXPOSE 8000

# الأمر النهائي للتشغيل المتوافق مع Render
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
