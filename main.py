from fastapi import FastAPI, Header, HTTPException, Request
import subprocess
import uvicorn
import os

app = FastAPI()
API_KEY = "NEON-EXOS-ULTIMATE-2026"

@app.get("/")
async def root():
    return {"status": "Neon Cyber-Engine is Live", "expert": "Taha"}

@app.post("/server/terminal")
async def execute(request: Request, x_api_key: str = Header(None)):
    if x_api_key != API_KEY:
        raise HTTPException(status_code=401, detail="Unauthorized Access")

    data = await request.json()
    cmd = data.get("cmd")

    try:
        # تنفيذ الأوامر مباشرة في نظام Linux الخاص بـ Render
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=30)
        return {
            "stdout": result.stdout,
            "stderr": result.stderr,
            "status": "Success"
        }
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    # الحصول على المنفذ من إعدادات Render البيئية
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
