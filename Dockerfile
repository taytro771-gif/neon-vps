FROM metasploitframework/metasploit-framework
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install fastapi uvicorn
WORKDIR /app
COPY main.py /app/main.py
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]