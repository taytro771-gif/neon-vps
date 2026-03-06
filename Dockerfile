FROM metasploitframework/metasploit-framework

# تثبيت المتطلبات
RUN apk update && apk add --no-cache python3 py3-pip
RUN pip3 install --no-cache-dir fastapi uvicorn --break-system-packages

WORKDIR /app

# إنشاء ملف السيرفر مباشرة من داخل Dockerfile لضمان الصلاحيات
RUN echo 'from fastapi import FastAPI, Header, HTTPException, Request \n\
import subprocess \n\
import uvicorn \n\
app = FastAPI() \n\
API_KEY = "NEON-EXOS-ULTIMATE-2026" \n\
@app.post("/server/terminal") \n\
async def execute(request: Request, x_api_key: str = Header(None)): \n\
    if x_api_key != API_KEY: raise HTTPException(status_code=401) \n\
    data = await request.json() \n\
    cmd = data.get("cmd") \n\
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True) \n\
    return {"stdout": result.stdout, "stderr": result.stderr} \n\
if __name__ == "__main__": \n\
    uvicorn.run(app, host="0.0.0.0", port=8000)' > main.py

EXPOSE 8000

# التشغيل باستخدام مسار بايثون الكامل
CMD ["python3", "/app/main.py"]ش
